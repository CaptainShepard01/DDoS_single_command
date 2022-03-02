$regex = "#.*";
$FileName = ".\commands\bombardier_commands.txt"

$NumberOfParameters = 2;

$Connections = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -First 1;
$Duration = Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip 1  | Select-Object -First 1;

$Command = "docker run -ti --rm alpine/bombardier -c " + $Connections + " -d " + $Duration + "s -l ";

Get-Content $FileName | Where-Object {-not ($_ -match $regex)} | Select-Object -Skip $NumberOfParameters | ForEach-Object {
	Start-Process powershell ($Command + $_.replace(' ', ''));
}
