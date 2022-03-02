$regex = "#.*";
$FileName = ".\commands\ddosify_commands.txt"

$NumberOfParameters = 3;

$Requests = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -First 1;
$Duration = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip 1  | Select-Object -First 1;
$Timeout = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip 2  | Select-Object -First 1;

$Part1 = "docker run -it --rm ddosify/ddosify ddosify -t ";
$Part2 = " -n " + $Requests + " -d " + $Duration + " -p ";
$Part3 =  " -m PUT -T " + $Timeout;

Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip $NumberOfParameters | ForEach-Object {
	$Target = $_.Split(' ');
	Start-Process powershell ($Part1 + $Target[0] + $Part2 + $Target[1].ToUpper() + $Part3);
}
