### 1. Создайте виртуальную машину Linux

```
Ответ: 

(взял готовую виртуальную машину из предыдущих заданий, добавил порт 8200)
Vagrant file=
Vagrant.configure("2") do |config|
 	config.vm.box = "bento/ubuntu-20.04"
	config.vm.network "forwarded_port", guest: 8200, host: 8200
	config.vm.network "forwarded_port", guest: 80, host: 80
	config.vm.network "forwarded_port", guest: 443, host: 443
	config.vm.network "forwarded_port", guest: 2222, host: 22

 end

> vagrant up
> vagrant ssh

```

### 2. Установите ufw и разрешите к этой машине сессии на порты 22 и 443, при этом трафик на интерфейсе localhost (lo) должен ходить свободно на все порты.

```
Ответ:

> sudo -i

> ufw status
Status: inactive

> ufw allow 22
Rules updated
Rules updated (v6)

> ufw allow 443
Rules updated
Rules updated (v6)

> ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup

> ufw status
Status: active

To                         Action      From
--                         ------      ----
22                         ALLOW       Anywhere
443                        ALLOW       Anywhere
22 (v6)                    ALLOW       Anywhere (v6)
443 (v6)                   ALLOW       Anywhere (v6)

```
### 3. Установите hashicorp vault (инструкция по ссылке).

```
Ответ:

> curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
> sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
> sudo apt-get update && sudo apt-get install vault
> vault status
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.9.2
Storage Type    inmem
Cluster Name    vault-cluster-4ddb12c8
Cluster ID      4057c807-da51-061d-df5d-8be88d474089
HA Enabled      false

> vault server -dev
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Go Version: go1.17.5
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: true, enabled: false
           Recovery Mode: false
                 Storage: inmem
                 Version: Vault v1.9.2
             Version Sha: f4c6d873e2767c0d6853b5d9ffc77b0d297bfbdf

WARNING! dev mode is enabled! In this mode, Vault runs entirely in-memory
and starts unsealed with a single unseal key. The root token is already
authenticated to the CLI, so you can immediately begin using Vault.

You may need to set the following environment variable:

    $ export VAULT_ADDR='http://127.0.0.1:8200'

The unseal key and root token are displayed below in case you want to
seal/unseal the Vault or re-authenticate.

Unseal Key: SUyXJZKiRmSryngtVBLasasHPb0eQzcD89quqUynfWw=
Root Token: s.CM3DLZd11DUiM4KxCtXZ4w6L


> sudo vault server -dev -dev-root-token-id s.CM3DLZd11DUiM4KxCtXZ4w6L
> export VAULT_ADDR='http://127.0.0.1:8200'

> ADMIN_TOKEN=$(vault token create -format=json -policy="admin" |                                                                                         jq -r ".auth.client_token")
-bash: jq: command not found

не оказалось программы jq, доустаовил:
> apt install jq


```

### 4. Создайте центр сертификации по инструкции (ссылка), и выпустите сертификат для использования его в настройке веб-сервера nginx (срок жизни сертификата - месяц).

```
Ответ:

root@vagrant:~#> vault secrets enable pki
Success! Enabled the pki secrets engine at: pki/

root@vagrant:~#> vault secrets tune -max-lease-ttl=87600h pki
Success! Tuned the secrets engine at: pki/

root@vagrant:~#> vault write -field=certificate pki/root/generate/internal \
>      common_name="example.com" \
>      ttl=87600h > CA_cert.crt

root@vagrant:~# vault write pki/config/urls \
>      issuing_certificates="$VAULT_ADDR/v1/pki/ca" \
>      crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
Success! Data written to: pki/config/urls

root@vagrant:~# vault secrets enable -path=pki_int pki
Success! Enabled the pki secrets engine at: pki_int/

root@vagrant:~# vault secrets tune -max-lease-ttl=43800h pki_int
Success! Tuned the secrets engine at: pki_int/

root@vagrant:~# vault write -format=json pki_int/intermediate/generate/internal                                                                                         \
>      common_name="example.com Intermediate Authority" \
>      | jq -r '.data.csr' > pki_intermediate.csr
root@vagrant:~# vault write -format=json pki/root/sign-intermediate csr=@pki_int                                                                                        ermediate.csr \
>      format=pem_bundle ttl="43800h" \
>      | jq -r '.data.certificate' > intermediate.cert.pem

root@vagrant:~# vault write pki_int/intermediate/set-signed certificate=@interme                                                                                        diate.cert.pem
Success! Data written to: pki_int/intermediate/set-signed

root@vagrant:~# vault write pki_int/roles/example-dot-com \
>      allowed_domains="example.com" \
>      allow_subdomains=true \
>      max_ttl="720h"
Success! Data written to: pki_int/roles/example-dot-com

root@vagrant:~# vault list pki_int/roles/
Keys
----
example-dot-com


делаем сертификаты для test.example.com, собираем в нужные файлы
vault write -format=json pki_int/issue/example-dot-com common_name="test.example.com" ttl=720h > /etc/nginx/ssl/test.example.com.crt

tail -n 4 test.example.com.crt
    "serial_number": "7d:2e:30:34:b5:07:7d:7f:56:5f:fc:06:7d:4c:ad:54:1c:8f:2b:d3"
  },
  "warnings": null
}


cat test.example.com.crt | jq -r .data.certificate > test.example.com.crt.pem

cat test.example.com.crt | jq -r .data.issuing_ca >> test.example.com.crt.pem

cat test.example.com.crt | jq -r .data.private_key > test.example.com.crt.key


```
### 5. Установите корневой сертификат созданного центра сертификации в доверенные в хостовой системе.

```
Ответ:

На хосте у меня Windows 10, поэтому файл с корневым сертификатом скопировал с помощью WinSCP и добавил в доверенные корневые центры сертификации.

добавил в c:\windows\syste32\etc\hosts
127.0.0.1 test.example.com

на виртуалке тоже добавил в /etc/hosts
127.0.0.1 test.example.com

и обновил корневые сертификаты:
> ln -s /root/CA_cert.crt /usr/local/share/ca-certificates/CA_cert.crt
> update-ca-certificates
Updating certificates in /etc/ssl/certs...
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.


```

### 6. Установите nginx.

```
Ответ:

> apt install nginx -y

# service nginx status
● nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/lib/systemd/system/nginx.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2022-01-17 15:08:51 UTC; 5 days ago
       Docs: man:nginx(8)
    Process: 778 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
    Process: 818 ExecStart=/usr/sbin/nginx -g daemon on; master_process on; (code=exited, status=0/SUCCESS)
   Main PID: 827 (nginx)
      Tasks: 3 (limit: 1071)
     Memory: 13.3M
     CGroup: /system.slice/nginx.service
             ├─ 827 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
             ├─3358 nginx: worker process
             └─3359 nginx: worker process
```

### 7. По инструкции ([ссылка](https://nginx.org/en/docs/http/configuring_https_servers.html)) настройте nginx на https, используя ранее подготовленный сертификат:
  - можно использовать стандартную стартовую страницу nginx для демонстрации работы сервера;
  - можно использовать и другой html файл, сделанный вами;

```  
  в папку /etc/ssl/, поместил сертификаты:
 цепочка открытых: сертификатов test.example.com.crt.pem
 приватный сертификат: 			test.example.com.crt.key

добавил конфигурационный файл /etc/nginx/comf.d/ssl.conf с таким содержанием:
server {
    listen              443 ssl;
    server_name         test.example.com;
    ssl_certificate     /etc/ssl/test.example.com.crt.pem;
    ssl_certificate_key /etc/ssl/test.example.com.crt.key;
    ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers         HIGH:!aNULL:!MD5;
}

> nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

> nginx -s reload

проверил что страница на 443 порту открывается

root@vagrant:/etc# curl -I https://test.example.com
HTTP/1.1 200 OK
Server: nginx/1.18.0 (Ubuntu)
Date: Sun, 23 Jan 2022 09:32:04 GMT
Content-Type: text/html
Content-Length: 612
Last-Modified: Tue, 21 Apr 2020 14:09:01 GMT
Connection: keep-alive
ETag: "5e9efe7d-264"
Accept-Ranges: bytes

```


### 8. Откройте в браузере на хосте https адрес страницы, которую обслуживает сервер nginx.

```
Ответ:

![сертификат валидный](https://github.com/antonh2o/devops-netology/blob/main/pcs-devsys-diplom/ssl_test.example.com.png)
![сертификат в браузере](https://github.com/antonh2o/devops-netology/blob/main/pcs-devsys-diplom/ssl_cert_test.example.com)

```

### 9. Создайте скрипт, который будет генерировать новый сертификат в vault:
  - генерируем новый сертификат так, чтобы не переписывать конфиг nginx;
  - перезапускаем nginx для применения нового сертификата.

```
Ответ:

> cat /home/vagrant/gen_certs.sh
#!/bin/bash

export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=$(cat /root/.vault-token)

ssl_dir="/etc/ssl"

cd $ssl_dir

/usr/bin/vault write -format=json pki_int/issue/example-dot-com common_name="test.example.com" ttl=720h > $ssl_dir/test.example.com.crt
cat $ssl_dir/test.example.com.crt | jq -r .data.certificate > $ssl_dir/test.example.com.crt.pem
cat $ssl_dir/test.example.com.crt | jq -r .data.issuing_ca >> $ssl_dir/test.example.com.crt.pem
cat $ssl_dir/test.example.com.crt | jq -r .data.private_key > $ssl_dir/test.example.com.crt.key
/usr/sbin/nginx -s reload

![сертификат после обновления](https://github.com/antonh2o/devops-netology/blob/main/pcs-devsys-diplom/ssl_new_test.example.com.png)

```

### 10. Поместите скрипт в crontab, чтобы сертификат обновлялся какого-то числа каждого месяца в удобное для вас время.

```
Ответ:

Добавил нижнюю строчку в crontab для проверки
> cat /etc/crontab:

# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
17 *    * * *   root    cd / && run-parts --report /etc/cron.hourly
25 6    * * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
47 6    * * 7   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6    1 * *   root    test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )
#
#
12 19 * * * root /home/vagrant/gen_certs.sh

в журнале сислог все случилось
> cat /var/log/syslog |grep -i cron
Jan 23 19:12:01 vagrant cron[5544]: (*system*) RELOAD (/etc/crontab)
Jan 23 19:12:01 vagrant CRON[8063]: (root) CMD (/home/vagrant/gen_certs.sh)

в браузере сертификат видно что обновился:
![сертификат после crontab](https://github.com/antonh2o/devops-netology/blob/main/pcs-devsys-diplom/ssl_crontab_test.example.com.png)

```
