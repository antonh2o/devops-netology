### Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

## Задача 1
# Опишите своими словами основные преимущества применения на практике IaaC паттернов.

```
Ответ:
 IaaC позволяет быстрее конфигурировать инфраструктуру и направлен на обеспечение прозрачности, 
 чтобы помочь другим командам со всего предприятия работать быстрее и эффективнее. Это освобождает дорогостоящие ресурсы для выполнения других важных задач.
 
 CI (Continuous Integration)  Непрерывная интеграция
 Основным преимуществом данного паттерна является сокращение стоимости исправления дефекта, за счёт его раннего выявления
  
 CD (Continuous Delivery) Непрерывная доставка (CD) — CI + CD.
 
Автоматизация — ключевой аспект любого CI/CD-пайплайна. Она позволяет сделать процесс релиза быстрым, легко повторяемым и надежным. 


```

# Какой из принципов IaaC является основополагающим?

```
Ответ:
Основной принцип IaaC - Идемпоте́нтность (лат. idem — тот же самый + potens — способный) — это свойство объекта или операции, при повторном выполнении
которой мы получаем результат идентичный предыдущему и всем последующим выполнениям.

```

 ## Задача 2

# Чем Ansible выгодно отличается от других систем управление конфигурациями?

```
Ответ:

Главное его отличие от других подобных систем в том, что Ansible использует существующую SSH инфраструктуру и не требует допольнительной учтановки специального окружения
 как другие (Saltstack, Chef, Puppet, и пр.).


```


# Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

```
Ответ:
Push надёжней, т.к. централизованно управляет конфигурацией и исключает ситуации, когда кто-то что-то исправил напрямую на сервере и не отразил в репозитории 
- это может потеряться или создавать непредсказуемые ситуации.

```
## Задача 3

# Установить на личный компьютер:

# VirtualBox
```
Windows 
Графический интерфейс VirtualBox
Версия 6.1.28 r147628 (Qt5.6.2)
```

# Vagrant

```
 > c:\homework\devops-netology\terminal\vagrant>vagrant -v
Vagrant 2.2.19

```

# Ansible

```
> root@vagrant:~# ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Jun  2 2021, 10:49:15) [GCC 9.4.0]
  
```

# Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.



## Задача 4 (*)

# Воспроизвести практическую часть лекции самостоятельно.

# Создать виртуальную машину.

# Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды

# docker ps

```
Ответ:

На хостовой машине Windows, пока не удалось воспроизвести задачу, пришлось ставить linux:

vagrant provision
==> server1.netology: Running provisioner: ansible...
Vagrant has automatically selected the compatibility mode '2.0'
according to the Ansible version installed (2.9.6).

Alternatively, the compatibility mode can be specified in your Vagrantfile:
https://www.vagrantup.com/docs/provisioning/ansible_common.html#compatibility_mode

    server1.netology: Running ansible-playbook...

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
changed: [server1.netology]

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=['git', 'curl'])

TASK [Installing docker] *******************************************************
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
ok: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

root@anton-HP-Pavilion-15-Notebook-PC:/home/anton/netology/src/vagrant# vagrant ssh
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Wed 02 Feb 2022 05:42:57 PM UTC

  System load:  0.28               Users logged in:          0
  Usage of /:   13.4% of 30.88GB   IPv4 address for docker0: 172.17.0.1
  Memory usage: 23%                IPv4 address for eth0:    10.0.2.15
  Swap usage:   0%                 IPv4 address for eth1:    192.168.192.11
  Processes:    111


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Wed Feb  2 17:41:13 2022 from 10.0.2.2
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES




```
