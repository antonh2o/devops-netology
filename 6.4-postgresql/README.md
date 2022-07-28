# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.
Подключитесь к БД PostgreSQL используя psql.
Воспользуйтесь командой \? для вывода подсказки по имеющимся в psql управляющим командам.
Найдите и приведите управляющие команды для:

- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql


```
- вывода списка БД
Ответ:
postgres=# \l
                               List of databases
   Name | Owner | Encoding | Collate | Ctype | Access privileges
-----------+---------+----------+------------+------------+---------------------
 postgres | pgadmin | UTF8 | en_US.utf8 | en_US.utf8 |
 template0 | pgadmin | UTF8 | en_US.utf8 | en_US.utf8 | =c/pgadmin +
           | | | | | pgadmin=CTc/pgadmin
 template1 | pgadmin | UTF8 | en_US.utf8 | en_US.utf8 | =c/pgadmin +
           | | | | | pgadmin=CTc/pgadmin
(3 rows)
```

- подключения к БД

```
\с postgres
```

- вывода списка таблиц
```
Ответ:
postgres=# \dtS
                    List of relations
   Schema | Name | Type | Owner
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate | table | pgadmin
 pg_catalog | pg_am | table | pgadmin
 pg_catalog | pg_amop | table | pgadmin
 pg_catalog | pg_amproc | table | pgadmin
 pg_catalog | pg_attrdef | table | pgadmin
 pg_catalog | pg_attribute | table | pgadmin
 pg_catalog | pg_auth_members | table | pgadmin
 pg_catalog | pg_authid | table | pgadmin
 pg_catalog | pg_cast | table | pgadmin
 pg_catalog | pg_class | table | pgadmin
 pg_catalog | pg_collation | table | pgadmin
 pg_catalog | pg_constraint | table | pgadmin
 pg_catalog | pg_conversion | table | pgadmin
 pg_catalog | pg_database | table | pgadmin
 pg_catalog | pg_db_role_setting | table | pgadmin
 pg_catalog | pg_default_acl | table | pgadmin
 pg_catalog | pg_depend | table | pgadmin
 pg_catalog | pg_description | table | pgadmin
 pg_catalog | pg_enum | table | pgadmin
 pg_catalog | pg_event_trigger | table | pgadmin
 pg_catalog | pg_extension | table | pgadmin
 pg_catalog | pg_foreign_data_wrapper | table | pgadmin
 pg_catalog | pg_foreign_server | table | pgadmin
 pg_catalog | pg_foreign_table | table | pgadmin
 pg_catalog | pg_index | table | pgadmin
 pg_catalog | pg_inherits | table | pgadmin
 pg_catalog | pg_init_privs | table | pgadmin
 pg_catalog | pg_language | table | pgadmin
 pg_catalog | pg_largeobject | table | pgadmin
 pg_catalog | pg_largeobject_metadata | table | pgadmin
 pg_catalog | pg_namespace | table | pgadmin
 pg_catalog | pg_opclass | table | pgadmin
 pg_catalog | pg_operator | table | pgadmin
 pg_catalog | pg_opfamily | table | pgadmin
 pg_catalog | pg_partitioned_table | table | pgadmin
 pg_catalog | pg_policy | table | pgadmin
 pg_catalog | pg_proc | table | pgadmin
 pg_catalog | pg_publication | table | pgadmin
 pg_catalog | pg_publication_rel | table | pgadmin
 pg_catalog | pg_range | table | pgadmin
 pg_catalog | pg_replication_origin | table | pgadmin
 pg_catalog | pg_rewrite | table | pgadmin
 pg_catalog | pg_seclabel | table | pgadmin
 pg_catalog | pg_sequence | table | pgadmin
 pg_catalog | pg_shdepend | table | pgadmin
 pg_catalog | pg_shdescription | table | pgadmin
 pg_catalog | pg_shseclabel | table | pgadmin
 pg_catalog | pg_statistic | table | pgadmin
 pg_catalog | pg_statistic_ext | table | pgadmin
 pg_catalog | pg_statistic_ext_data | table | pgadmin
 pg_catalog | pg_subscription | table | pgadmin
 pg_catalog | pg_subscription_rel | table | pgadmin
 pg_catalog | pg_tablespace | table | pgadmin
 pg_catalog | pg_transform | table | pgadmin
 pg_catalog | pg_trigger | table | pgadmin
 pg_catalog | pg_ts_config | table | pgadmin
 pg_catalog | pg_ts_config_map | table | pgadmin
 pg_catalog | pg_ts_dict | table | pgadmin
 pg_catalog | pg_ts_parser | table | pgadmin
 pg_catalog | pg_ts_template | table | pgadmin
 pg_catalog | pg_type | table | pgadmin
 pg_catalog | pg_user_mapping | table | pgadmin
 public | orders | table | postgres
(63 rows)

```

- Вывод содержания таблиц:

```
Ответ:
postgres=# \dS+
                                              List of relations
   Schema | Name | Type | Owner | Persistence | Size | Description
------------+---------------------------------+----------+----------+-------------+------------+-------------
 pg_catalog | pg_aggregate | table | pgadmin | permanent | 56 kB |
 pg_catalog | pg_am | table | pgadmin | permanent | 40 kB |
 pg_catalog | pg_amop | table | pgadmin | permanent | 80 kB |
 pg_catalog | pg_amproc | table | pgadmin | permanent | 64 kB |
 pg_catalog | pg_attrdef | table | pgadmin | permanent | 16 kB |
 pg_catalog | pg_attribute | table | pgadmin | permanent | 456 kB |
 pg_catalog | pg_auth_members | table | pgadmin | permanent | 40 kB |
 pg_catalog | pg_authid | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_available_extension_versions | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_available_extensions | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_cast | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_class | table | pgadmin | permanent | 136 kB |
 pg_catalog | pg_collation | table | pgadmin | permanent | 240 kB |
 pg_catalog | pg_config | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_constraint | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_conversion | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_cursors | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_database | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_db_role_setting | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_default_acl | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_depend | table | pgadmin | permanent | 488 kB |
 pg_catalog | pg_description | table | pgadmin | permanent | 376 kB |
 pg_catalog | pg_enum | table | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_event_trigger | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_extension | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_file_settings | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_foreign_data_wrapper | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_foreign_server | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_foreign_table | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_group | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_hba_file_rules | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_index | table | pgadmin | permanent | 64 kB |
 pg_catalog | pg_indexes | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_inherits | table | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_init_privs | table | pgadmin | permanent | 56 kB |
 pg_catalog | pg_language | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_largeobject | table | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_largeobject_metadata | table | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_locks | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_matviews | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_namespace | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_opclass | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_operator | table | pgadmin | permanent | 144 kB |
 pg_catalog | pg_opfamily | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_partitioned_table | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_policies | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_policy | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_prepared_statements | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_prepared_xacts | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_proc | table | pgadmin | permanent | 688 kB |
 pg_catalog | pg_publication | table | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_publication_rel | table | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_publication_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_range | table | pgadmin | permanent | 40 kB |
 pg_catalog | pg_replication_origin | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_replication_origin_status | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_replication_slots | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_rewrite | table | pgadmin | permanent | 656 kB |
 pg_catalog | pg_roles | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_rules | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_seclabel | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_seclabels | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_sequence | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_sequences | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_settings | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_shadow | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_shdepend | table | pgadmin | permanent | 40 kB |
 pg_catalog | pg_shdescription | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_shmem_allocations | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_shseclabel | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_stat_activity | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_all_indexes | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_all_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_archiver | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_bgwriter | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_database | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_database_conflicts | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_gssapi | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_progress_analyze | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_progress_basebackup | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_progress_cluster | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_progress_create_index | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_progress_vacuum | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_replication | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_slru | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_ssl | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_subscription | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_sys_indexes | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_sys_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_user_functions | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_user_indexes | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_user_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_wal_receiver | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_xact_all_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_xact_sys_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_xact_user_functions | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stat_xact_user_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_all_indexes | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_all_sequences | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_all_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_sys_indexes | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_sys_sequences | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_sys_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_user_indexes | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_user_sequences | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statio_user_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_statistic | table | pgadmin | permanent | 248 kB |
 pg_catalog | pg_statistic_ext | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_statistic_ext_data | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_stats | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_stats_ext | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_subscription | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_subscription_rel | table | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_tables | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_tablespace | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_timezone_abbrevs | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_timezone_names | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_transform | table | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_trigger | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_ts_config | table | pgadmin | permanent | 40 kB |
 pg_catalog | pg_ts_config_map | table | pgadmin | permanent | 56 kB |
 pg_catalog | pg_ts_dict | table | pgadmin | permanent | 48 kB |
 pg_catalog | pg_ts_parser | table | pgadmin | permanent | 40 kB |
 pg_catalog | pg_ts_template | table | pgadmin | permanent | 40 kB |
 pg_catalog | pg_type | table | pgadmin | permanent | 120 kB |
 pg_catalog | pg_user | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_user_mapping | table | pgadmin | permanent | 8192 bytes |
 pg_catalog | pg_user_mappings | view | pgadmin | permanent | 0 bytes |
 pg_catalog | pg_views | view | pgadmin | permanent | 0 bytes |
 public | orders | table | postgres | permanent | 8192 bytes |
 public | orders_id_seq | sequence | postgres | permanent | 8192 bytes |
(131 rows)

```

- выход из psql

```
Ответ:
postgres=# \q
```

## Задача 2
Используя psql создайте БД test_database.

Изучите бэкап БД.

Восстановите бэкап БД в test_database.

```
Ответ:
postgres=# create database test_database;
CREATE DATABASE
postgres=# exit

root@69cf7ae02e4f:/# psql --username=pgadmin test_database </media/postgresql/backup/test_dump.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
```

Перейдите в управляющую консоль psql внутри контейнера.
Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

```
postgres=# \c test_database
You are now connected to database "test_database" as user "postgres".

test_database=# ANALYZE VERBOSE public.orders;
INFO: analyzing "public.orders"
INFO: "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```

Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.

```
test_database=# SELECT avg_width FROM pg_stats WHERE tablename='orders';
 avg_width
-----------
         4
        16
         4
(3 rows)
```

## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).
Предложите SQL-транзакцию для проведения данной операции.

```
Ответ:

test_database=# BEGIN;
CREATE TABLE orders_1 (LIKE orders);
INSERT INTO orders_1 SELECT * FROM orders WHERE price >499;
DELETE FROM orders WHERE price >499;
CREATE TABLE orders_2 (LIKE orders);
INSERT INTO orders_2 SELECT * FROM orders WHERE price <=499;
DELETE FROM orders WHERE price <=499;
COMMIT;
BEGIN
CREATE TABLE
INSERT 0 3
DELETE 3
CREATE TABLE
INSERT 0 5
DELETE 5
COMMIT


test_database=# SELECT * FROM public.orders;
 id | title | price
----+-------+-------
(0 rows)

test_database=# SELECT * FROM public.orders_1;
 id | title | price
----+--------------------+-------
  2 | My little database | 500
  6 | WAL never lies | 900
  8 | Dbiezdmin | 501
(3 rows)

test_database=# SELECT * FROM public.orders_2;
 id | title | price
----+----------------------+-------
  1 | War and peace | 100
  3 | Adventure psql time | 300
  4 | Server gravity falls | 300
  5 | Log gossips
```

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

```
Ответ можно, прописав правила вставки, например:
CREATE RULE orders_insert_to_more AS ON INSERT TO orders WHERE ( price > 499 ) DO INSTEAD INSERT INTO orders_more_499_price VALUES (NEW.*);
```

## Задача 4

Используя утилиту pg_dump создайте бекап БД test_database.
```
Ответ:
pg_dump -h localhost -U postgres test_database >/media/postgresql/backup/test_database_backup.sql
```

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?

```
Ответ:
Уникальность столбца title можно осуществить следующим образом:

CREATE unique INDEX title_un ON public.orders(title);
CREATE INDEX

```
