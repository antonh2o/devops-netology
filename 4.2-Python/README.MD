### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-02-py/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос        | Ответ         |
| ------------- | ------------- |
| Какое значение будет присвоено переменной `c`?  | будет ошибка TypeError: unsupported operand type(s) for +: 'int' and 'str'  |
| Как получить для переменной `c` значение 12?    | для этого c = str(a) + b |
| Как получить для переменной `c` значение 3?     | для это c = a + int(b)   |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, 
относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, 
где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
repo = "~/devops-netology/" #путь до гит репозитория
bash_command = ["cd "+repo, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(repo+prepare_result)
      #  break - не надо прерывать цикл после первой итерации
```

### Вывод скрипта при запуске при тестировании:
```
root@vagrant:~/devops-netology/4.2-PYTHON# ./python.py
~/devops-netology/4.2-PYTHON/README.MD
~/devops-netology/4.2-PYTHON/python.py

```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, 
а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, 
что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
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

```

### Вывод скрипта при запуске при тестировании:
```
 ./python.py ~/devops-netology/
argv[1] is: /root/devops-netology/
/root/devops-netology/4.2-PYTHON/README.MD
/root/devops-netology/4.2-PYTHON/python.py

root@vagrant:~/devops-netology/4.2-PYTHON# ./python.py ~/
argv[1] is: /root/
fatal: not a git repository (or any of the parent directories): .git

```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, 
кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой 
очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. 
Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. 
Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. 
Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. 
Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. 
Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os, socket, json

data_file = 'dns-ip.json'

if not os.path.exists(data_file):
    data = {}
    data['servers'] = []
    server_dns_list = ['drive.google.com', 'mail.google.com', 'google.com']
for server_dns in server_dns_list:
    data['servers'].append( {'dns': server_dns, 'ip': socket.gethostbyname(server_dns)} )
with open(data_file, 'w') as outfile:
    json.dump(data, outfile)
with open(data_file) as json_file:
    data = json.load(json_file)
    write_new_data = False
    for server in data['servers']:
        curr_ip = socket.gethostbyname(server['dns'])
print(f'{server["dns"]} - {curr_ip}')

if curr_ip != server['ip']:.
    print(f'[ERROR] {server["dns"]} IP mismatch: old {server["ip"]} new {curr_ip}')
    write_new_data = True
    server['ip'] = curr_ip
if write_new_data:.
    with open(data_file, 'w') as outfile:
        json.dump(data, outfile)

```

### Вывод скрипта при запуске при тестировании:
```
./check_dns.py
google.com - 74.125.131.138
[ERROR] google.com IP mismatch: old 74.125.131.113 new 74.125.131.138
root@vagrant:~/devops-netology/4.2-PYTHON#

```

