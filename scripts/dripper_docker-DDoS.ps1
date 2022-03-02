$regex = "#.*";
$FileName = ".\commands\dripper_commands.txt"

$NumberOfParameters = 1;

$Duration = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -First 1;

$Part1 = "docker run -it --rm alexmon1989/dripper:1.0.1 -s ";
$Part2 = " -p ";
$Part3 = " -t " + $Duration;

Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip $NumberOfParameters | ForEach-Object {
	$Target = $_.replace(' ', '').Split(':');
	Start-Process powershell ($Part1 + $Target[0] + $Part2 + $Target[1] + $Part3);
}