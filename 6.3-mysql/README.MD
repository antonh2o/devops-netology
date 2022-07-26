# Домашнее задание к занятию "6.3. MySQL"

## Задача 1
Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

```
version: '3'

volumes:
  data: {}
  backup: {}

services:
  mysqldb:
    image: mysql:8.0
    cap_add:
      - SYS_NICE
    restart: always
    environment:
      - MYSQL_DATABASE=mysql
      - MYSQL_ROOT_PASSWORD=mypass
    ports:
      - '3306:3306'
    volumes:
      - data:/var/lib/mysql
      - backup:/media/mysql/backup
      - ./my.cnf:/etc/mysql/conf.d/my.cnf

```

Изучите бэкап БД и восстановитесь из него.
Перейдите в управляющую консоль mysql внутри контейнера.
Используя команду \h получите список управляющих команд.
Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД.

```
Ответ:

mysql> \s
--------------
mysql  Ver 8.0.29 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          17
Current database:       test
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.29 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 28 min 1 sec

Threads: 4  Questions: 126  Slow queries: 0  Opens: 212  Flush tables: 3  Open tables: 130  Queries per second avg: 0.074
--------------
```

Подключитесь к восстановленной БД и получите список таблиц из этой БД.
```
Ответ:
mysql> USE test_db;
Database changed

mysql> SHOW tables;
+----------------+
| Tables_in_test |
+----------------+
| orders         |
+----------------+
1 row in set (0.00 sec)

```

Приведите в ответе количество записей с price > 300.

```
Ответ:

COUNT(*) FROM orders WHERE price > 300;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)

```

## Задача 2
Создайте пользователя test в БД c паролем test-pass, используя:

плагин авторизации mysql_native_password
срок истечения пароля - 180 дней
количество попыток авторизации - 3
максимальное количество запросов в час - 100
аттрибуты пользователя:
Фамилия "Pretty"
Имя "James"

```
Ответ:
mysql> CREATE USER 'test' IDENTIFIED WITH mysql_native_password BY 'test-pass';
Query OK, 0 rows affected (0.00 sec)

mysql> show variables like 'default_password_lifetime'
    -> ;
+---------------------------+-------+
| Variable_name             | Value |
+---------------------------+-------+
| default_password_lifetime | 0     |
+---------------------------+-------+
1 row in set (0.01 sec)
```

Предоставьте привелегии пользователю test на операции SELECT базы test_db.
```
mysql> GRANT SELECT ON test_db.* TO test@localhost;
Query OK, 0 rows affected, 1 warning (0.01 sec)
```


Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче.

```
Ответ:
mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test';
+------+-----------+------------------------------------------------+
| USER | HOST      | ATTRIBUTE                                      |
+------+-----------+------------------------------------------------+
| test | localhost | {"last_name": "Pretty", "first_name": "James"} |
+------+-----------+------------------------------------------------+
1 row in set (0.00 sec)
```


## Задача 3
Установите профилирование SET profiling = 1. Изучите вывод профилирования команд SHOW PROFILES;.
Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

на MyISAM
на InnoDB

```
Ответ:
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SHOW PROFILES;
Empty set, 1 warning (0.00 sec)

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.05 sec)
Records: 5  Duplicates: 0  Warnings: 0

SHOW PROFILES;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|        1 | 0.00013800 | ALTER TABLE orders ENGINE = MyISAM |
|        2 | 0.00018550 | SELECT DATABASE()                  |
|        3 | 0.00144950 | show databases                     |
|        4 | 0.00109875 | show tables                        |
|        5 | 0.01523100 | ALTER TABLE orders ENGINE = MyISAM |
|        6 | 0.02052750 | ALTER TABLE orders ENGINE = InnoDB |
+----------+------------+------------------------------------+
6 rows in set, 1 warning (0.00 sec)
```

## Задача 4

Изучите файл my.cnf в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):

Скорость IO важнее сохранности данных
Нужна компрессия таблиц для экономии места на диске
Размер буффера с незакомиченными транзакциями 1 Мб
Буффер кеширования 30% от ОЗУ
Размер файла логов операций 100 Мб

Приведите в ответе измененный файл my.cnf.

```
cat /etc/mysql/conf.d/my.cnf
[mysqld]

#Скорость IO важнее сохранности данных
# 0 - скорость
innodb_flush_log_at_trx_commit = 0

#Set compression
innodb_file_per_table = ON

# Barracuda - формат файла с сжатием, увеличивает нагрузку на процессор
innodb_file_format = Barracuda

#Размер буфера с незакомиченными транзакциями 1 Мб
innodb_log_buffer_size = 1M

#Буфер кеширования 30% от ОЗУ
innodb_buffer_pool_size = 2G

# Размер файла логов операций 100 Мб
innodb_log_file_size = 100M
```
