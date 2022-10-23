Role Name
=========

Роль для установки vector.
- Установка vector
- Создание systemd unit Vector
- Конфигурирование vector на передачу данных в clickhouse

Requirements
------------

Role Variables
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

Требуется роль [clickhouse-role](https://github.com/antonh2o/clickhouse-role)

Example Playbook
----------------

```yaml
hosts: vector
roles:
  - role: vector-role
```

License
-------

MIT

Author Information
------------------
