Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"

1. Работа c HTTP через телнет.
Подключитесь утилитой телнет к сайту stackoverflow.com telnet stackoverflow.com 80
отправьте HTTP запрос
GET /questions HTTP/1.0
HOST: stackoverflow.com
[press enter]
[press enter]
В ответе укажите полученный HTTP код, что он означает?

307 внутренний редирект,
видимо ответ должен быть как в браузере 
ждал несколько часов, так ответ не дождался
telnet stackoverflow.com 80
Trying 151.101.193.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0


2. Повторите задание 1 в браузере, используя консоль разработчика F12.
откройте вкладку Network
отправьте запрос http://stackoverflow.com
найдите первый ответ HTTP сервера, откройте вкладку Headers
укажите в ответе полученный HTTP код.
проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
приложите скриншот консоли браузера в ответ.



3. Какой IP адрес у вас в интернете?

	Ответ
	IP адрес:217.114.224.18

4. Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois

	Ответ:
	whois -h whois.radb.net 217.114.224.18
route:          217.114.224.0/20
descr:          FTTB users block
descr:          "Golden ISP" Ltd.
descr:          13, Antona Valeka str.
descr:          Ekaterinburg, 620014
descr:          Russia
origin:         AS3253
notify:         noc@mplik.ru
mnt-by:         RU-CORBINA-MNT
created:        2008-04-08T07:31:14Z
last-modified:  2019-04-17T14:58:57Z
source:         RIPE
remarks:        ****************************
remarks:        * THIS OBJECT IS MODIFIED
remarks:        * Please note that all data that is generally regarded as personal
remarks:        * data has been removed from this object.
remarks:        * To view the original object, please query the RIPE Database at:
remarks:        * http://www.ripe.net/whois
remarks:        ****************************
root@vm-acd4db49:~# whois -h whois.radb.net AS3253
aut-num:        AS3253
as-name:        SOVINTEL-EF-AS
remarks:        ------------------------------------------------------------
remarks:        Upstreams:
remarks:        ------------------------------------------------------------
import:         from AS3216 action pref=400; accept ANY
export:         to AS3216 announce AS3253 AS3253:AS-EF-INTERNET AS3253:AS-URALRELCOM AS3253:AS-URMFISTINTERNET AS3253:AS-URRTCOMMPEERING AS3253:AS-URRTPEERING AS3253:AS-URGLDNPEERING
remarks:        ------------------------------------------------------------
org:            ORG-ES15-RIPE
admin-c:        DUMY-RIPE
tech-c:         DUMY-RIPE
status:         ASSIGNED
notify:         noc@mplik.ru
mnt-by:         RIPE-NCC-END-MNT
mnt-by:         AS3253-MNT
created:        1970-01-01T00:00:00Z
last-modified:  2018-09-04T09:49:33Z
source:         RIPE
remarks:        ****************************
remarks:        * THIS OBJECT IS MODIFIED
remarks:        * Please note that all data that is generally regarded as personal
remarks:        * data has been removed from this object.
remarks:        * To view the original object, please query the RIPE Database at:
remarks:        * http://www.ripe.net/whois
remarks:        ****************************

	
5. Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute
	
	Ответ: с хостинга нетангелс, потому что из домашнего адреса много звездочек
	 traceroute -An 8.8.8.8
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  10.12.9.14 [*]  0.176 ms  0.118 ms  0.092 ms
 2  10.12.0.1 [*]  0.253 ms  0.262 ms  0.219 ms
 3  10.100.0.100 [*]  0.236 ms  0.252 ms  0.219 ms
 4  194.226.100.138 [*]  30.655 ms  28.347 ms  34.910 ms
 5  74.125.244.133 [AS15169]  28.340 ms  29.119 ms  30.785 ms
 6  142.251.51.187 [AS15169]  63.938 ms 72.14.232.84 [AS15169]  27.536 ms  29.195 ms
 7  216.239.48.163 [AS15169]  80.601 ms 72.14.237.201 [AS15169]  32.333 ms 216.239.48.163 [AS15169]  31.814 ms
 8  172.253.64.113 [AS15169]  36.225 ms 216.239.49.115 [AS15169]  33.379 ms 142.250.56.125 [AS15169]  82.878 ms
 9  * * *
10  * * *
11  * * *
12  * * *
13  * * *
14  * * 8.8.8.8 [AS15169]  41.490 ms

6. Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?
 My traceroute  [v0.93]
vm-acd4db49 (185.41.163.204)                                                                           2021-12-11T16:17:32+0000
Keys:  Help   Display mode   Restart statistics   Order of fields   quit
                                                                                       Packets               Pings
 Host                                                                                Loss%   Snt   Last   Avg  Best  Wrst StDev
 1. AS???    10.12.9.14                                                               0.0%    15    0.2   0.2   0.2   0.2   0.0
 2. AS???    10.12.0.1                                                                0.0%    15    0.3   0.3   0.3   0.3   0.0
 3. AS???    10.100.0.100                                                             0.0%    15    0.4   0.4   0.3   0.5   0.0
 4. AS???    194.226.100.138                                                          0.0%    15   28.4  29.1  28.3  34.0   1.6
 5. AS15169  74.125.244.181                                                           0.0%    15   40.1  31.3  29.1  40.1   3.7
 6. AS15169  72.14.232.84                                                             0.0%    15   27.6  27.9  27.6  28.6   0.3
 7. AS15169  216.239.48.163                                                           0.0%    15   43.1  31.8  30.0  43.1   3.6
 8. AS15169  216.239.46.139                                                           0.0%    15   35.9  35.7  34.9  39.4   1.1
 9. (waiting for reply)
10. (waiting for reply)
11. (waiting for reply)
12. (waiting for reply)
13. (waiting for reply)
14. (waiting for reply)
15. (waiting for reply)
16. (waiting for reply)
17. (waiting for reply)
18. AS15169  8.8.8.8                                                                  7.1%    14   35.8  32.4  31.7  35.8   1.5

7. Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? воспользуйтесь утилитой dig

	Ответ
	 dig dns.google.com NS

; <<>> DiG 9.16.1-Ubuntu <<>> dns.google.com NS
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 35896
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 0

;; QUESTION SECTION:
;dns.google.com.                        IN      NS

;; AUTHORITY SECTION:
google.com.             60      IN      SOA     ns1.google.com. dns-admin.google.com. 415658330 900 900 1800 60

;; Query time: 43 msec
;; SERVER: 91.201.54.5#53(91.201.54.5)
;; WHEN: Sat Dec 11 16:26:59 UTC 2021
;; MSG SIZE  rcvd: 82

dig dns.google.com A

; <<>> DiG 9.16.1-Ubuntu <<>> dns.google.com A
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 38881
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;dns.google.com.                        IN      A

;; ANSWER SECTION:
dns.google.com.         900     IN      A       8.8.4.4
dns.google.com.         900     IN      A       8.8.8.8

;; Query time: 39 msec
;; SERVER: 91.201.54.5#53(91.201.54.5)
;; WHEN: Sat Dec 11 16:27:34 UTC 2021
;; MSG SIZE  rcvd: 64


8. Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? воспользуйтесь утилитой dig
	
	Ответ:
	dig -x 8.8.8.8

; <<>> DiG 9.16.1-Ubuntu <<>> -x 8.8.8.8
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 36064
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0

;; QUESTION SECTION:
;8.8.8.8.in-addr.arpa.          IN      PTR

;; ANSWER SECTION:
8.8.8.8.in-addr.arpa.   14268   IN      PTR     dns.google.

;; Query time: 0 msec
;; SERVER: 91.201.54.5#53(91.201.54.5)
;; WHEN: Sat Dec 11 16:47:58 UTC 2021
;; MSG SIZE  rcvd: 62

