# Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3"

1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
telnet route-views.routeviews.org
Username: rviews
show ip route x.x.x.x/32
show bgp x.x.x.x/32

```
	Ответ:
	route-views>sh ip route 217.114.224.18/32
                                      ^
route-views>sh bgp 217.114.224.18/32
% Network not in table
route-views>sh bgp 217.114.224.18
BGP routing table entry for 217.114.224.0/23, version 1401191192
Paths: (23 available, best #9, table default)
  Not advertised to any peer
  Refresh Epoch 1
  101 3356 3216 3253
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 101:20100 101:20110 101:22100 3216:2001 3216:4466 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      Extended Community: RT:101:22100 RT:3253:1010
      path 7FE054D58888 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 14315 6453 6453 3356 3216 3253
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 14315:5000 53767:5000
      path 7FE15382F018 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 3216 3253
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:4466 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      Extended Community: RT:3253:1010
      path 7FE09DB32A70 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 3216 3253
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:4466 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067 3549:2581 3549:30840
      Extended Community: RT:3253:1010
      path 7FE14C577CB8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 3216 3253
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE0CA086310 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 3356 3216 3253
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:4466 3356:2 3356:22 3356:100 3356:123 3356:503 3356:903 3356:2067
      Extended Community: RT:3253:1010
      path 7FE0F12A99C8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 1103 3216 3253
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin incomplete, localpref 100, valid, external
      Community: 3216:2001 3216:4466
      Extended Community: RT:3253:1010
      path 7FE0FD2E5E38 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 3356 3216 3253
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE15B052878 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 3216 3253
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external, best
      path 7FE0C0DB1510 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  2497 3216 3253
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin incomplete, localpref 100, valid, external
      path 7FE0F24375D8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 3356 3216 3253
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30515 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE086770CC0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7660 2516 6762 3216 3253
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin incomplete, localpref 100, valid, external
      Community: 2516:1030 7660:9003
      path 7FE1263BA0C8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  4901 6079 3356 3216 3253
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE0D0232E70 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 3
  3303 3216 3253
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin incomplete, localpref 100, valid, external
      Community: 3216:2001 3216:4466 3303:1004 3303:1006 3303:1030 3303:3056
      path 7FE0E056C690 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  701 5511 3216 3253
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin incomplete, localpref 100, valid, external
      path 7FE14AC79190 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 3356 3216 3253
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE172A2A2C8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 12552 3216 3253
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin incomplete, localpref 100, valid, external
      Community: 12552:12000 12552:12100 12552:12101 12552:22000
      Extended Community: 0x43:100:1
      path 7FE17175A028 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  8283 3216 3253
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin incomplete, metric 0, localpref 100, valid, external
      Community: 3216:2001 3216:4466 8283:1 8283:101 65000:52254
      Extended Community: RT:3253:1010
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001
      path 7FE115C5EAE0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1221 4637 3216 3253
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin incomplete, localpref 100, valid, external
      path 7FE10AEDDBB0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 3356 3216 3253
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external
      Community: 3257:8794 3257:30043 3257:50001 3257:54900 3257:54901
      path 7FE1753E5CE8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 3216 3253
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE007B10E90 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1351 6939 3216 3253
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE0B479DD08 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  19214 3257 3356 3216 3253
    208.74.64.40 from 208.74.64.40 (208.74.64.40)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8108 3257:30048 3257:50002 3257:51200 3257:51203
      path 7FE0A7316F50 RPKI State not found
      rx pathid: 0, tx pathid: 0	  
	
```	

2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.

```
	Ответ:
	установил bird2 
	>apt install bird2
	добавил настроки в файл /etc/bird/bird.conf:
	protocol direct {
	 ipv4; # Connect to default IPv4 table
	 interface "dummy*";
	}

	внес изменения в файл /etc/network/interfaces:
	auto dummy0
	iface dummy0 inet static
	 address 10.1.1.1/32
	 pre-up ip link add dummy0 type dummy
	 post-down ip link del dummy0
	 
	> ip -c -br link
		lo               UNKNOWN        00:00:00:00:00:00 <LOOPBACK,UP,LOWER_UP>
		eth0             UP             08:00:27:73:60:cf <BROADCAST,MULTICAST,UP,LOWER_UP>
		dummy0           UNKNOWN        9a:43:2e:2d:6a:fc <BROADCAST,NOARP,UP,LOWER_UP>
	> ip -c -br r
		default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100
		10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15
		10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100
		10.1.1.1 dev dummy0 proto bird scope link metric 32			
```	

3. Проверьте открытые TCP порты в Ubuntu, какие протоколы и приложения используют эти порты? Приведите несколько примеров.

```
	Ответ: sshd использует 22 порт, grafana на 3000 порту
	> ss -tlap
		State       Recv-Q      Send-Q                Local Address:Port                   Peer Address:Port      Process
		LISTEN      0           4096                        0.0.0.0:sunrpc                      0.0.0.0:*          users:(("rpcbind",pid=570,fd=4),("systemd",pid=1,fd=42))
		LISTEN      0           4096                  127.0.0.53%lo:domain                      0.0.0.0:*          users:(("systemd-resolve",pid=571,fd=13))
		LISTEN      0           128                         0.0.0.0:ssh                         0.0.0.0:*          users:(("sshd",pid=709,fd=3))
		LISTEN      0           4096                      127.0.0.1:8125                        0.0.0.0:*          users:(("netdata",pid=658,fd=40))
		LISTEN      0           4096                        0.0.0.0:19999                       0.0.0.0:*          users:(("netdata",pid=658,fd=4))
		ESTAB       0           0                         10.0.2.15:ssh                        10.0.2.2:54917      users:(("sshd",pid=1528,fd=4),("sshd",pid=1488,fd=4))
		ESTAB       0           0                         127.0.0.1:44316                     127.0.0.1:9090       users:(("prometheus",pid=634,fd=6))
		LISTEN      0           4096                           [::]:sunrpc                         [::]:*          users:(("rpcbind",pid=570,fd=6),("systemd",pid=1,fd=44))
		LISTEN      0           4096                              *:9110                              *:*          users:(("node_exporter",pid=662,fd=3))
		LISTEN      0           128                            [::]:ssh                            [::]:*          users:(("sshd",pid=709,fd=4))
		LISTEN      0           4096                              *:3000                              *:*          users:(("grafana-server",pid=679,fd=8))
		LISTEN      0           4096                          [::1]:8125                           [::]:*          users:(("netdata",pid=658,fd=39))
		LISTEN      0           4096                              *:9090                              *:*          users:(("prometheus",pid=634,fd=7))
		ESTAB       0           0                [::ffff:127.0.0.1]:9090             [::ffff:127.0.0.1]:44316      users:(("prometheus",pid=634,fd=3))
		ESTAB       0           0                             [::1]:52360                         [::1]:9090       users:(("prometheus",pid=634,fd=20))
		ESTAB       0           0                             [::1]:9090                          [::1]:52360      users:(("prometheus",pid=634,fd=21))
			
```	
4. Проверьте используемые UDP сокеты в Ubuntu, какие протоколы и приложения используют эти порты?

```
	Ответ: днс использует 53 порт
	> ss -ulap
		State        Recv-Q       Send-Q              Local Address:Port                Peer Address:Port       Process
		UNCONN       0            0                   127.0.0.53%lo:domain                   0.0.0.0:*           users:(("systemd-resolve",pid=571,fd=12))
		UNCONN       0            0                  10.0.2.15%eth0:bootpc                   0.0.0.0:*           users:(("systemd-network",pid=402,fd=19))
		UNCONN       0            0                         0.0.0.0:sunrpc                   0.0.0.0:*           users:(("rpcbind",pid=570,fd=5),("systemd",pid=1,fd=43))
		UNCONN       0            0                       127.0.0.1:8125                     0.0.0.0:*           users:(("netdata",pid=658,fd=26))
		UNCONN       0            0                            [::]:sunrpc                      [::]:*           users:(("rpcbind",pid=570,fd=7),("systemd",pid=1,fd=45))
		UNCONN       0            0                           [::1]:8125                        [::]:*           users:(("netdata",pid=658,fd=25))
```	

5. Используя diagrams.net, создайте L3 диаграмму вашей домашней сети или любой другой сети, с которой вы работали.

```
	Ответ:
	из соображения конфиденциальности схему рабочей сети нельзя публиковать, поэтому воспользуюсь чужой схемой
```	
![Схема сети](https://github.com/antonh2o/devops-netology/blob/main/3.6-7-8-NET/03/Layer3.png)
	
	
	
