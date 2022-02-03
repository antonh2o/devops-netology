# Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

	
	
1. Установите Bitwarden плагин для браузера. Зарегистрируйтесь и сохраните несколько паролей.

	```
	Ответ:
	
![Bitwarden](https://github.com/antonh2o/devops-netology/blob/main/SEC/bitwarden.png)

	```

2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

	```
	Ответ:
![Bitwarden2fa](https://github.com/antonh2o/devops-netology/blob/main/SEC/bitwarden2fa.png)

	```

3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.

	```
	Ответ: установил 
	> sudo apt install apache2
	cd /etc/ssl
	сгенерировал
	openssl req -new -key ./private/server.key -out ./certs/server.csr
	openssl req -new -key ./private/server.key -out ./certs/server.csr
	openssl x509 -req -days 700 -in ./certs/server.csr -signkey ./private/server.key -out server.cert
	настроил /etc/apache2/sites-enabled/default-ssl.conf
	SSLCertificateFile     /etc/ssl/server.cert                                                                                                            
	SSLCertificateKeyFile  /etc/ssl/private/server.key
	
![certificate](https://github.com/antonh2o/devops-netology/blob/main/SEC/ssl1.png)
![certificate2](https://github.com/antonh2o/devops-netology/blob/main/SEC/ssl2.png)
	```

4. Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).

	```
	Ответ: просканировал сайт https://testssl.sh/
![testssl.txt](https://github.com/antonh2o/devops-netology/blob/main/SEC/testssl.txt)

	```

5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.

	```
	Ответ:
	> ssh-keygen
			Generating public/private rsa key pair.
		Enter file in which to save the key (/root/.ssh/id_rsa):
		Enter passphrase (empty for no passphrase):
		Enter same passphrase again:
		Your identification has been saved in /root/.ssh/id_rsa
		Your public key has been saved in /root/.ssh/id_rsa.pub
		The key fingerprint is:
		SHA256:c4+4InUlepF0dW//goCC4Rs2rnmOP7p4bkfLpa3RFWs root@vagrant
		The key's randomart image is:
		+---[RSA 3072]----+
		|           .. .  |
		|        . .  . . |
		|    .  ..o      o|
		|   . o  ++.    ..|
		|    * ..E+o     .|
		|   o.=++o+ + .  .|
		|   o+*.o. . o . .|
		| .o+O.o  .     . |
		|.+BB++ ..        |
		+----[SHA256]-----+
		root@vagrant:~#
		fish: Waiting for initial line...

		fish: Waiting for initial line...

	скопировал публичный ключ на сервер в 
		cat id_rsa.pub >> /root/.ssh/authorized_keys
		после этого успешно подключился к ссш серверу

	```

6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

	```
	Ответ:
	touch ~/.ssh/config
	отредактировал для сервера iotw.ru:
	Host dev
    HostName iotw.ru
    User root
    Port 22
	 успешно
	 > ssh dev
		Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-81-generic x86_64)
		Last login: Mon Dec 20 23:06:39 2021 from 217.114.224.18
		root@vm-acd4db49:~# exit
		logout
		Connection to iotw.ru closed.

	```

7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

	```
	Ответ:
	> tcpdump -c 100 -w mypcap.pcap
![wireshark-pcap.png](https://github.com/antonh2o/devops-netology/blob/main/SEC/wireshark-pcap.png)

	```
