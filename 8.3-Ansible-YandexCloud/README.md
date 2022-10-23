# Домашнее задание к занятию "08.03 Использование Yandex Cloud"                                                                     
                                                                                                                                    
## Подготовка к выполнению                                                                                                          
                                                                                                                                    
1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.                                         
 
```
Ответ:
с помощью terraform разворациваются 3 узла
```
[terraform](terraform)

Ссылка на репозиторий LightHouse: https://github.com/VKCOM/lighthouse                                                               
                                                                                                                                    
## Основная часть                                                                                                                   
                                                                                                                                    
1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает lighthouse.                                  
2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.                                          
3. Tasks должны: скачать статику lighthouse, установить nginx или любой другой webserver, настроить его конфиг для открытия lighthou
```
lighthouse разворачивается с помощью роли lighthouse-role
```
4. Приготовьте свой собственный inventory файл `prod.yml`.
```
prod.yml создается с помощью терраформ в файле inventory.tf
```                                                                          
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.                                                             
```
ошибки были исправлены в прошлом задании 8.2
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.                                                              

```
check не очень помогает, так как при чеке скачивание не происходит и папки не создаются
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.                   
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.  
```
--diff показал что плейбук идемпотентен
```
                                         
9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги
```
Роль для установки clickhouse.                                                                                                      
- Установка:                                                                                                                        
  - clickhouse-client                                                                                                               
  - clickhouse-server                                                                                                               
  - clickhouse-common-static                                                                                                        
- Создаётся БД                                                                                                                      
- Создаётся таблица для логов                                                                                                       
- Создаётся пользователь для записи в БД                                                                                            
- Конфигурируется clickhouse-server для работы внешних подключений  

------------ 
Роль для установки lighthouse.                                                                                                      
- Устновка Git                                                                                                                      
- Скачивание lighthouse из репозитория                                                                                              
- Конфигурирование lighthouse                                                                                                       
                                                                                                                                    
Requirements                                                                                                                        
------------                                                                                                                        
                                                                                                                                    
- Должен быть установлен git. Если его нет, роль произведёт его установку                                                           
- Требуется отдельная установка и настройка Nginx   

Роль для установки vector.                                                                                                          
- Установка vector                                                                                                                  
- Создание systemd unit Vector                                                                                                      
- Конфигурирование vector на передачу данных в clickhouse                                                                           
                                                                                
--------------                                                                                                                      
Переменные для установки кредов                                                                                                     
defaults/main.yml:                                                                                                                  
```yaml                                                                                                                             
clickhouse_user: netology                                                                                                           
clickhouse_password: netology                                                                                                       
```                                                                                                                                 
                                                                                                                                    
Конфигурация для сбора и передачи логов содержится в vars/main.yml                                                                  
                                                                                                                                    
Dependencies                                                                                                                        
------------                                                                                                                        
                                                                                                                                    
В `inventory` должен быть хост `clickhouse01`                                                                                       
```yaml                                                                                                                             
endpoint: http://{{ clickhouse01_ip }}:8123                                                                                         
```                                        

10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте с

```
Ответ:
Подготовил репозиторий - (текущий)
С помошью terraform разворачиваются три ноды и с помощью ansible playbook site.yml  
с помощью ролей разворачиваются 
clickhouse, lighthouse, vector:

clickhouse-role:
```
[clickhouse-role](https://github.com/antonh2o/clickhouse-role)
```
lighthouse-role:
```
[lighthouse-role](https://github.com/antonh2o/lighthouse-role)

```
vector-role:
```
[vector-role](https://github.com/antonh2o/vector-role)

в текущем репозитории  playbook:
[roles](roles)
```
Вывод:

null_resource.cluster (local-exec): PLAY RECAP *********************************************************************
null_resource.cluster (local-exec): clickhouse01.ru-central1.internal : ok=9    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
null_resource.cluster (local-exec): lighthouse01.ru-central1.internal : ok=10   changed=8    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
null_resource.cluster (local-exec): vector01.ru-central1.internal : ok=8    changed=7    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

null_resource.cluster: Creation complete after 3m33s [id=2015107478909900520]

Apply complete! Resources: 9 added, 0 changed, 0 destroyed.

```

---                                                                                                                                 
                                                                                                                                    
### Как оформить ДЗ?                                                                                                                
                                                                                                                                    
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.                                                      
                                                                                                                                    
---                                                                                                                                 
