# Домашнее задание к занятию "8.4 Работа с Roles"

## Подготовка к выполнению
1. (Необязательно) Познакомтесь с [lighthouse](https://youtu.be/ymlrNlaHzIY?t=929)
2. Создайте два пустых публичных репозитория в любом своём проекте: vector-role и lighthouse-role.
3. Добавьте публичную часть своего ключа к своему профилю в github.

## Основная часть

Наша основная цель - разбить наш playbook на отдельные roles. Задача: сделать roles для clickhouse, vector и lighthouse и написать playbook для использования этих ролей. Ожидаемый результат: существуют три ваших репозитория: два с roles и один с playbook.

1. Создать в старой версии playbook файл `requirements.yml` и заполнить его следующим содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.11.0"
       name: clickhouse 
   ```

2. При помощи `ansible-galaxy` скачать себе эту роль.
3. Создать новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.
4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. 
5. Перенести нужные шаблоны конфигов в `templates`.
6. Описать в `README.md` обе роли и их параметры.
7. Повторите шаги 3-6 для lighthouse. Помните, что одна роль должна настраивать один продукт.
8. Выложите все roles в репозитории. Проставьте тэги, используя семантическую нумерацию Добавьте roles в `requirements.yml` в playbook.

9. Переработайте playbook на использование roles. Не забудьте про зависимости lighthouse и возможности совмещения `roles` с `tasks`.
10. Выложите playbook в репозиторий.
[roles](roles)
11. В ответ приведите ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.
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
