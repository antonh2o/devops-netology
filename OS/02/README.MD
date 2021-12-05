 Домашнее задание к занятию "3.4. Операционные системы, лекция 2"

1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. 
Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. 
Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:
поместите его в автозагрузку,
предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.

	Ответ:
	Создал Unit файл сервиса, вот он
	>cat /etc/systemd/system/node_exporter.service
	
		[Unit]
		Description=Node_Exporter
		Wants=network-online.target
		After=network-online.target

		[Service]
		User=prometheus
		Group=prometheus
		Type=simple
		ExecStart=/usr/bin/node_exporter
		EnvironmentFile=/etc/default/node_exporter

		[Install]
		WantedBy=multi-user.target

	Проверка после установки службы и запуска:
	Проверка запуска
	> ps -auxw|grep exporter
	
		prometh+    1320  1.2  1.7 717372 17456 ?        Ssl  15:32   0:03 /usr/bin/node_exporter	
		root        1357  0.0  0.0   9032   672 pts/0    S+   15:36   0:00 grep --color=auto exporter
	
	> systemctl status node_exporter
	
		● node_exporter.service - Node_Exporter
		Loaded: loaded (/lib/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
		Active: active (running) since Sun 2021-12-05 15:32:20 UTC; 2min 44s ago
		Main PID: 1320 (node_exporter)
		Tasks: 6 (limit: 1071)
		Memory: 8.1M
		CGroup: /system.slice/node_exporter.service
		     └─1320 /usr/bin/node_exporter

		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.667Z caller=node_exporter.go:115 level=info collector=the>
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.667Z caller=node_exporter.go:115 level=info collector=time
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.667Z caller=node_exporter.go:115 level=info collector=tim>
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.667Z caller=node_exporter.go:115 level=info collector=udp>
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.667Z caller=node_exporter.go:115 level=info collector=una>
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.667Z caller=node_exporter.go:115 level=info collector=vms>
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.667Z caller=node_exporter.go:115 level=info collector=xfs
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.667Z caller=node_exporter.go:115 level=info collector=zfs
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.673Z caller=node_exporter.go:199 level=info msg="Listenin>
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.675Z caller=tls_config.go:195 level=info msg="TLS is disa


	Проверка Переменных окружения
	>cat /proc/1320/environ
	
		LANG=en_US.UTF-	8LANGUAGE=en_US:PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/binHOME=/var/lib/prometheusLOGNAME=prometheusUSER=prometheusINVOCATION_ID=c944ca19be0944aab8de742d9307a63eJOURNAL_STREAM=9:31081ARGS=root@vagrant:~

	Проверка остановки
	>journalctl -xe
	
		Dec 05 15:32:20 vagrant node_exporter[1320]: ts=2021-12-05T15:32:20.675Z caller=tls_config.go:195 level=info msg="TLS is disa>
		Dec 05 15:33:53 vagrant sudo[1344]:     root : TTY=pts/0 ; PWD=/root ; USER=root ; COMMAND=/usr/bin/cat /proc/1320/environ
		Dec 05 15:33:53 vagrant sudo[1344]: pam_unix(sudo:session): session opened for user root by vagrant(uid=0)
		Dec 05 15:33:53 vagrant sudo[1344]: pam_unix(sudo:session): session closed for user root
		Dec 05 15:39:05 vagrant sudo[1364]:     root : TTY=pts/0 ; PWD=/root ; USER=root ; COMMAND=/usr/bin/cat /proc/1320/environ
		Dec 05 15:39:05 vagrant sudo[1364]: pam_unix(sudo:session): session opened for user root by vagrant(uid=0)
		Dec 05 15:39:05 vagrant sudo[1364]: pam_unix(sudo:session): session closed for user root
		Dec 05 15:40:37 vagrant systemd[1]: Stopping Node_Exporter...
		-- Subject: A stop job for unit node_exporter.service has begun executionvagrant systemd[1]: Stopping Node_Exporter...
		-- Subject: A stop job for unit node_exporter.service has begun execution
		-- Defined-By: systemd
		-- Support: http://www.ubuntu.com/support
		--
		-- A stop job for unit node_exporter.service has begun execution.
		--
		-- The job identifier is 1100.
		Dec 05 15:40:37 vagrant systemd[1]: node_exporter.service: Succeeded.
		-- Subject: Unit succeeded
		-- Defined-By: systemd
		-- Support: http://www.ubuntu.com/support
		--
		-- The unit node_exporter.service has successfully entered the 'dead' state.
		Dec 05 15:40:37 vagrant systemd[1]: Stopped Node_Exporter.
		-- Subject: A stop job for unit node_exporter.service has finished
		-- Defined-By: systemd
		-- Support: http://www.ubuntu.com/support
		--
		-- A stop job for unit node_exporter.service has finished.
		--
		-- The job identifier is 1100 and the job result is done.


2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, 
которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

	Ответ:
	
		CPU 

		node_cpu_seconds_total{cpu="0",mode="idle"} 5160.86
		node_cpu_seconds_total{cpu="0",mode="iowait"} 1.68
		node_cpu_seconds_total{cpu="0",mode="irq"} 0
		node_cpu_seconds_total{cpu="0",mode="nice"} 0.26
		node_cpu_seconds_total{cpu="0",mode="softirq"} 1.37
		node_cpu_seconds_total{cpu="0",mode="steal"} 0
		node_cpu_seconds_total{cpu="0",mode="system"} 98.88
		node_cpu_seconds_total{cpu="0",mode="user"} 52.71
		node_cpu_seconds_total{cpu="1",mode="idle"} 5172.02
		node_cpu_seconds_total{cpu="1",mode="iowait"} 2.46
		node_cpu_seconds_total{cpu="1",mode="irq"} 0
		node_cpu_seconds_total{cpu="1",mode="nice"} 0.03
		node_cpu_seconds_total{cpu="1",mode="softirq"} 3.76
		node_cpu_seconds_total{cpu="1",mode="steal"} 0
		node_cpu_seconds_total{cpu="1",mode="system"} 102.02
		node_cpu_seconds_total{cpu="1",mode="user"} 57.97

		MEMORY
		
		node_memory_Active_bytes 3.44711168e+08
		node_memory_MemFree_bytes 1.6594944e+08
		node_memory_MemTotal_bytes 1.028694016e+09

		disk
		
		node_disk_io_time_seconds_total{device="dm-0"} 27.276
		node_disk_io_time_seconds_total{device="dm-1"} 0.08
		node_disk_io_time_seconds_total{device="sda"} 27.412
		node_disk_io_time_weighted_seconds_total{device="dm-0"} 32.736000000000004
		node_disk_io_time_weighted_seconds_total{device="dm-1"} 0.07200000000000001
		node_disk_io_time_weighted_seconds_total{device="sda"} 5.856
		node_disk_read_bytes_total{device="dm-0"} 3.78139648e+08
		node_disk_read_bytes_total{device="dm-1"} 3.342336e+06
		node_disk_read_bytes_total{device="sda"} 3.91898112e+08
		node_disk_read_time_seconds_total{device="dm-0"} 18.404
		node_disk_read_time_seconds_total{device="dm-1"} 0.07200000000000001
		node_disk_read_time_seconds_total{device="sda"} 8.834
		node_disk_reads_completed_total{device="dm-0"} 10940
		node_disk_reads_completed_total{device="dm-1"} 146
		node_disk_reads_completed_total{device="sda"} 7615
		node_disk_write_time_seconds_total{device="dm-0"} 14.332
		node_disk_write_time_seconds_total{device="dm-1"} 0
		node_disk_write_time_seconds_total{device="sda"} 11.059000000000001
		node_disk_writes_completed_total{device="dm-0"} 8948
		node_disk_writes_completed_total{device="dm-1"} 0
		node_disk_writes_completed_total{device="sda"} 4905
		node_disk_writes_merged_total{device="dm-0"} 0
		node_disk_writes_merged_total{device="dm-1"} 0
		node_disk_writes_merged_total{device="sda"} 4054
		node_disk_written_bytes_total{device="dm-0"} 6.3295488e+07
		node_disk_written_bytes_total{device="dm-1"} 0
		node_disk_written_bytes_total{device="sda"} 5.9565056e+07	

		Network
		
		node_network_receive_bytes_total{device="eth0"} 623628
		node_network_receive_bytes_total{device="lo"} 7.921131e+06
		node_network_receive_packets_total{device="eth0"} 2067
		node_network_receive_packets_total{device="lo"} 8854
		node_network_speed_bytes{device="eth0"} 1.25e+08
		node_network_transmit_bytes_total{device="eth0"} 438803
		node_network_transmit_bytes_total{device="lo"} 7.921131e+06

3. Установите в свою виртуальную машину Netdata. Воспользуйтесь готовыми пакетами для установки (sudo apt install -y netdata). После успешной установки:
в конфигурационном файле /etc/netdata/netdata.conf в секции [web] замените значение с localhost на bind to = 0.0.0.0,
добавьте в Vagrantfile проброс порта Netdata на свой локальный компьютер и сделайте vagrant reload:
config.vm.network "forwarded_port", guest: 19999, host: 19999
После успешной перезагрузки в браузере на своем ПК (не в виртуальной машине) вы должны суметь зайти на localhost:19999. 
Ознакомьтесь с метриками, которые по умолчанию собираются Netdata и с комментариями, которые даны к этим метрикам.

	Ответ: 


		сделано, ознакомился
		
		sudo apt install netdata; lsof -i :19999
		
		![netdata](https://user-images.githubusercontent.com/55792818/144754173-7b0ff407-652d-495c-ba74-df99f44e814a.png)

		
		COMMAND PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
		netdata 693 netdata    4u  IPv4  25090      0t0  TCP *:19999 (LISTEN)
	
	
4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

	Ответ: 

		> dmesg |grep virtual
		[    0.009891] CPU MTRRs all blank - virtualized system.
		[    0.357550] Booting paravirtualized kernel on KVM
		[    0.582276] Performance Events: PMU not available due to virtualization, using software events only.
		[    4.535677] systemd[1]: Detected virtualization oracle.
	
5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

	Ответ: 

		> cat /proc/sys/fs/nr_open
		1048576
		значение по умолчанию fs.nr_open это 1024*1024 = 1048576.
		Максимальное значение fs.nr_open is ограничено значением sysctl_nr_open_max в ядре, which is 2147483584 on x86_64.
		Note: The value of "Max open files"(ulimit -n) is limited to fs.nr_open value.
	
6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; 
покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). 
Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

	Ответ: 
	
		> unshare -f --pid --mount-proc /bin/bash
		root@vagrant:~# sleep 1h &
		[1] 8
		root@vagrant:~# ps -auxw |more
		USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
		root           1  0.0  0.4   9968  4236 pts/1    S    13:08   0:00 /bin/bash
		root           8  0.0  0.0   8076   532 pts/1    S    13:08   0:00 sleep 1h
		root           9  0.0  0.3  11680  3560 pts/1    R+   13:08   0:00 ps -auxw
		root          10  0.0  0.0   8288   868 pts/1    S+   13:08   0:00 more
	
7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). 
Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. 
Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

		Ответ: 
		Логическая бомба (известная также как fork bomb), забивающая память системы
		dmesg | grep fork
		cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-4.scope
		limit -u устанавливает лимит процессов на пользователя
		Например limit -u 20 - будет 20 процессов на пользователя
