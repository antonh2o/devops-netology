#!/usr/bin/env python3

import os
import sys
import subprocess

repo = "~/devops-netology/" #если в командной строке нет аргументов
repo=sys.argv[1]
import subprocess

bash_command = ["cd " + repo, "git status"]
print(f'argv[1] is: {repo}')

with subprocess.Popen(['git', 'status'], stdout=subprocess.PIPE) as proc:
    result = proc.stdout.read().decode("utf-8")
if result.find('not') == -1:
    print('Данный каталог не содержит репозитория!')
else:
    result_os = os.popen(' && '.join(bash_command)).read()
    is_change = False
    for result in result_os.split('\n'):
     if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(repo+prepare_result)
