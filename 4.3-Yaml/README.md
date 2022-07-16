# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"

## Обязательные задания

1. Мы выгрузили JSON, который получили через API запрос к нашему сервису:
	```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            },
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
	```
  Нужно найти и исправить все ошибки, которые допускает наш сервис
	```
Ответ:
неэкранированный спецсимвол \t (горизонтальная табуляция)
пропущен пробел между : и [ 
[ и { желательно с новой строки для красоты и наглядноости
в первом ip значение не похоже на ip не хватает кавычек
во втором ip нет закрывающейся двойной кавычки и в значении не хватает кавычек

    { "info" : "Sample JSON output from our service\\t",
        "elements" : 
        [
            {
             "name" : "first",
             "type" : "server",
             "ip" : "71.75.0.1"
            },
            {
             "name" : "second",
             "type" : "proxy",
             "ip" : "71.78.22.43"
            }
        ]
    }
	```


2. В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. 
К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. 
Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}. Формат записи YAML по одному сервису: - имя сервиса: его IP.
Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

```
Ответ:

# !/usr/bin/env python3

import os, json, yaml, time


site_list = ['drive.google.com', 'mail.google.com', 'google.com']
site_dict = {}

def check_list_of_sites(site_list, site_dict):

    for site_url in site_list:
        site_dict=check_site_dns(site_url, site_dict)
    return site_dict


def check_site_dns(site_url, site_dict):
    site_new_ip = []


    result_os = os.popen(f'dig +short {site_url} | grep  -E \'[0-9]\'')

    for result in result_os:
        # For any ip delete \n
        site_new_ip.append(result.replace("\n",""))

    print('site_new_ip: ', site_new_ip)

    if site_dict.get(site_url) != None:

        site_old_ip = site_dict[site_url]
        i = 0
        ip_changed = False
        while i < len(site_old_ip):
            if site_old_ip[i] == site_new_ip[i]:
                print(f'{site_url} - {site_old_ip[i]}.')
            else:
                print(f'[ERROR] {site_url} IP mismatch: {site_old_ip[i]} {site_new_ip[i]}.')
                ip_changed = True
            i = i + 1

    else:
        #If it's first execution
        site_dict[site_url] = site_new_ip
        print('site_dict==', site_dict)
        ip_changed = True

    if ip_changed == True:
        with open("servers_ip.json", "w") as fp_json:
            json.dump(site_dict, fp_json, indent=2)
        with open("servers_ip.yaml", "w") as fp_yaml:
            yaml.dump(site_dict, fp_yaml, explicit_start=True, explicit_end=True)

    return site_dict

while True:
    site_dict = check_list_of_sites(site_list, site_dict)
    print("site_dict==", site_dict)
    time.sleep(5)

```


## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

---

### Как сдавать задания

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
