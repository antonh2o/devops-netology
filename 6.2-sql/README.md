# Домашнее задание к занятию "6.2. SQL"

### Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.
Приведите получившуюся команду или docker-compose манифест.

```
Ответ: cat docker-compose.yml

version: '3.6'

volumes:
  data: {}
  backup: {}

services:

  postgres:
    image: postgres:12
    container_name: postgresql
    ports:
      - "127.0.0.1:5432:5432"
    volumes:
      - data:/var/lib/postgresql/data
      - backup:/media/postgresql/backup
    environment:
      POSTGRES_USER: "pgadmin"
      POSTGRES_PASSWORD: "pgpass"
      POSTGRES_DB: "postgres"
    restart: always

```

### Задача 2
В БД из задачи 1:

создайте пользователя test-admin-user и БД test_db
в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
создайте пользователя test-simple-user
предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
Таблица orders:

id (serial primary key)
наименование (string)
цена (integer)
Таблица clients:

id (serial primary key)
фамилия (string)
страна проживания (string, index)
заказ (foreign key orders)
Приведите:

итоговый список БД после выполнения пунктов выше,
описание таблиц (describe)
SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
список пользователей с правами над таблицами test_db


```
Ответ:

docker exec -it postgresql bash
 root@4d982027bed8:/# export PGPASSWORD=pgpass && psql -h localhost -U pgadmin postgres
 psql (12.11 (Debian 12.11-1.pgdg110+1))
 Type "help" for help.

postgres=# CREATE USER "test-admin-user" WITH PASSWORD 'password';
postgres=# CREATE DATABASE test_db;

\c test_db;

test_db=# \l+
                                                                      List of databases
   Name    |  Owner  | Encoding |  Collate   |   Ctype    |      Access privileges       |  Size   | Tablespace |                Description
-----------+---------+----------+------------+------------+------------------------------+---------+------------+--------------------------------------------
 postgres  | pgadmin | UTF8     | en_US.utf8 | en_US.utf8 |                              | 8137 kB | pg_default | default administrative connection database
 template0 | pgadmin | UTF8     | en_US.utf8 | en_US.utf8 | =c/pgadmin                  +| 7825 kB | pg_default | unmodifiable empty database
           |         |          |            |            | pgadmin=CTc/pgadmin          |         |            |
 template1 | pgadmin | UTF8     | en_US.utf8 | en_US.utf8 | =c/pgadmin                  +| 7825 kB | pg_default | default template for new databases
           |         |          |            |            | pgadmin=CTc/pgadmin          |         |            |
 test_db   | pgadmin | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/pgadmin                 +| 8137 kB | pg_default |
           |         |          |            |            | pgadmin=CTc/pgadmin         +|         |            |
           |         |          |            |            | "test-simple-user"=c/pgadmin |         |            |
(4 rows)


test_db=# CREATE TABLE orders (
    id SERIAL,
    наименование VARCHAR,
    цена INTEGER,
    PRIMARY KEY (id)
);

test_db=# CREATE TABLE clients (
    id SERIAL,
    фамилия VARCHAR,
    "страна проживания" VARCHAR,
    заказ INTEGER,
    PRIMARY KEY (id),
    CONSTRAINT fk_заказ
      FOREIGN KEY(заказ)
     REFERENCES orders(id)
);
test_db=# CREATE INDEX ON clients("страна проживания");
test_db=# GRANT ALL ON TABLE orders, clients TO "test-admin-user";
test_db=# CREATE USER "test-simple-user" WITH PASSWORD 'password';
test_db=# GRANT CONNECT ON DATABASE test_db TO "test-simple-user";
test_db=# GRANT USAGE ON SCHEMA public TO "test-simple-user";
test_db=# GRANT SELECT, INSERT, UPDATE, DELETE ON orders, clients TO "test-simple-user";

test_db=# \d+ clients
                                                           Table "public.clients"
      Column       |       Type        | Collation | Nullable |               Default               | Storage  | Stats target | Description
-------------------+-------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer           |           | not null | nextval('clients_id_seq'::regclass) | plain    |              |
 фамилия           | character varying |           |          |                                     | extended |              |
 страна проживания | character varying |           |          |                                     | extended |              |
 заказ             | integer           |           |          |                                     | plain    |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна проживания_idx" btree ("страна проживания")
Foreign-key constraints:
    "fk_заказ" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

test_db=# \d+ orders
                                                        Table "public.orders"
    Column    |       Type        | Collation | Nullable |              Default               | Storage  | Stats target | Description
--------------+-------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer           |           | not null | nextval('orders_id_seq'::regclass) | plain    |              |
 наименование | character varying |           |          |                                    | extended |              |
 цена         | integer           |           |          |                                    | plain    |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "fk_заказ" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap


Проверка прав пользователей:

test_db=# SELECT
    grantee, table_name, privilege_type
FROM
    information_schema.table_privileges
WHERE
    grantee in ('test-admin-user','test-simple-user')
    and table_name in ('clients','orders')
;
     grantee      | table_name | privilege_type
------------------+------------+----------------
 test-admin-user  | orders     | INSERT
 test-admin-user  | orders     | SELECT
 test-admin-user  | orders     | UPDATE
 test-admin-user  | orders     | DELETE
 test-admin-user  | orders     | TRUNCATE
 test-admin-user  | orders     | REFERENCES
 test-admin-user  | orders     | TRIGGER
 test-simple-user | orders     | INSERT
 test-simple-user | orders     | SELECT
 test-simple-user | orders     | UPDATE
 test-simple-user | orders     | DELETE
 test-admin-user  | clients    | INSERT
 test-admin-user  | clients    | SELECT
 test-admin-user  | clients    | UPDATE
 test-admin-user  | clients    | DELETE
 test-admin-user  | clients    | TRUNCATE
 test-admin-user  | clients    | REFERENCES
 test-admin-user  | clients    | TRIGGER
 test-simple-user | clients    | INSERT
 test-simple-user | clients    | SELECT
 test-simple-user | clients    | UPDATE
 test-simple-user | clients    | DELETE
(22 rows)

```
### Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:

- вычислите количество записей для каждой таблицы
- приведите в ответе:
 - запросы
 - результаты их выполнения.

```
Ответ:

test_db=# INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);

Проверка:

test_db=# SELECT * FROM orders;
 id | наименование | цена
----+--------------+------
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000
(5 rows)

test_db=# SELECT count(1) FROM orders;
 count
-------
     5
(1 row)

test_db=# INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');


test_db=# SELECT * FROM clients;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |
  2 | Петров Петр Петрович | Canada            |
  3 | Иоганн Себастьян Бах | Japan             |
  4 | Ронни Джеймс Дио     | Russia            |
  5 | Ritchie Blackmore    | Russia            |
(5 rows)

test_db=# SELECT count(1) FROM clients;
 count
-------
     5
(1 row)
```

### Задача 4
Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.
Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
Подсказка - используйте директиву `UPDATE`.


```
Ответ:

test_db=# UPDATE clients
SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Книга')
WHERE "фамилия"='Иванов Иван Иванович';

test_db=# UPDATE clients
SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Монитор')
WHERE "фамилия"='Петров Петр Петрович';

test_db=# UPDATE clients
SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Гитара')
WHERE "фамилия"='Иоганн Себастьян Бах';

test_db# SELECT c.* FROM clients c JOIN orders o ON c.заказ = o.id;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(3 rows)

```

### Задача 5
Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 (используя директиву EXPLAIN).
Приведите получившийся результат и объясните что значат полученные значения.

```
test_db# EXPLAIN SELECT c.* FROM clients c JOIN orders o ON c.заказ = o.id;
                               QUERY PLAN
------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=72)
   Hash Cond: (c."заказ" = o.id)
   ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=72)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=4)
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=4)
(5 rows)

EXPLAIN выводит план выполнения, генерируемый планировщиком PostgreSQL для заданного оператора. План выполнения показывает, как будут сканироваться таблицы, затрагиваемые оператором — просто последовательно, по индексу и т. д. — а если запрос связывает несколько таблиц, какой алгоритм соединения будет выбран для объединения считанных из них строк. Наибольший интерес в выводимой информации представляет ожидаемая стоимость выполнения оператора, которая показывает, сколько, по мнению планировщика, будет выполняться этот оператор (это значение измеряется в единицах стоимости, которые не имеют точного определения, но обычно это обращение к странице на диске). Фактически выводятся два числа: стоимость запуска до выдачи первой строки и общая стоимость выдачи всех строк.
```

### Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
Остановите контейнер с PostgreSQL (но не удаляйте volumes).
Поднимите новый пустой контейнер с PostgreSQL.
Восстановите БД test_db в новом контейнере.
Приведите список операций, который вы применяли для бэкапа данных и восстановления.

```
Бэкап БД test_db:
root@4d982027bed8:/# export PGPASSWORD=pgpass && pg_dump -U pgadmin test_db > /media/postgresql/backup/test_db.sql
root@4d982027bed8:/# ls /media/postgresql/backup/
test_db.sql

Восстановление БД test_db:
root@dad28bef7fb5:/# export PGPASSWORD=pgpass && psql -U pgadmin -f /media/postgresql/backup/test_db.sql test_db
```
