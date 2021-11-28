	Домашнее задание к занятию "3.3. Операционные системы, лекция 1"

1. Какой системный вызов делает команда cd? В прошлом ДЗ мы выяснили, 
что cd не является самостоятельной программой, это shell builtin, 
поэтому запустить strace непосредственно на cd не получится. 
Тем не менее, вы можете запустить strace на /bin/bash -c 'cd /tmp'. 
В этом случае вы увидите полный список системных вызовов, которые делает сам bash при старте. 
Вам нужно найти тот единственный, который относится именно к cd. Обратите внимание, 
что strace выдаёт результат своей работы в поток stderr, а не в stdout.

	Ответ:
	stat("/tmp", {st_mode=S_IFDIR|S_ISVTX|0777, st_size=4096, ...}) = 0
	chdir("/tmp")
	
2. Попробуйте использовать команду file на объекты разных типов на файловой системе. Например:
vagrant@netology1:~$ file /dev/tty
/dev/tty: character special (5/0)
vagrant@netology1:~$ file /dev/sda
/dev/sda: block special (8/0)
vagrant@netology1:~$ file /bin/bash
/bin/bash: ELF 64-bit LSB shared object, x86-64
Используя strace выясните, где находится база данных file на основании которой она делает свои догадки.

	Ответ:
	openat(AT_FDCWD, "/usr/share/misc/magic.mgc", O_RDONLY) = 3
	
    также ищет но не может найти базу данных в файлах:
	stat("/root/.magic.mgc", 0x7ffe03198d10) = -1 ENOENT (No such file or directory)
	stat("/root/.magic", 0x7ffe03198d10)    = -1 ENOENT (No such file or directory)
	openat(AT_FDCWD, "/etc/magic.mgc", O_RDONLY) = -1 ENOENT (No such file or directory)
	
3. Предположим, приложение пишет лог в текстовый файл. Этот файл оказался удален (deleted в lsof), 
однако возможности сигналом сказать приложению переоткрыть файлы или просто перезапустить приложение – нет. 
Так как приложение продолжает писать в удаленный файл, место на диске постепенно заканчивается. 
Основываясь на знаниях о перенаправлении потоков предложите способ обнуления открытого удаленного файла (чтобы освободить место на файловой системе).

	Ответ:
	 Сделал запись в лог файл так 	>atop -w /var/log/deleted.log 0 200
	lsof |grep delet
	atop      4835                          root    5u      REG              253,0    19866     231088 /var/log/deleted.log
	  почистил так
	echo>/proc/4835/fd/5
	
4. Занимают ли зомби-процессы какие-то ресурсы в ОС (CPU, RAM, IO)?

	Ответ: 
	Зомби-процессы освобождает все свои ресурсы, но не очищается запись о зомби процессах в таблице процессов
	
5. В iovisor BCC есть утилита opensnoop:
root@vagrant:~# dpkg -L bpfcc-tools | grep sbin/opensnoop
/usr/sbin/opensnoop-bpfcc
На какие файлы вы увидели вызовы группы open за первую секунду работы утилиты? 
Воспользуйтесь пакетом bpfcc-tools для Ubuntu 20.04. Дополнительные сведения по установке.

	Ответ:
	# /usr/sbin/opensnoop-bpfcc
	PID    COMM               FD ERR PATH
	389    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.procs
	389    systemd-udevd      14   0 /sys/fs/cgroup/unified/system.slice/systemd-udevd.service/cgroup.threads
	608    irqbalance          6   0 /proc/interrupts
	608    irqbalance          6   0 /proc/stat
	608    irqbalance          6   0 /proc/irq/20/smp_affinity
	608    irqbalance          6   0 /proc/irq/0/smp_affinity
	608    irqbalance          6   0 /proc/irq/1/smp_affinity
	608    irqbalance          6   0 /proc/irq/8/smp_affinity
	608    irqbalance          6   0 /proc/irq/12/smp_affinity
	608    irqbalance          6   0 /proc/irq/14/smp_affinity
	608    irqbalance          6   0 /proc/irq/15/smp_affinity
	846    vminfo              4   0 /var/run/utmp
	597    dbus-daemon        -1   2 /usr/local/share/dbus-1/system-services
	597    dbus-daemon        18   0 /usr/share/dbus-1/system-services
	597    dbus-daemon        -1   2 /lib/dbus-1/system-services
	597    dbus-daemon        18   0 /var/lib/snapd/dbus-1/system-services/
	846    vminfo              4   0 /var/run/utmp	

6. Какой системный вызов использует uname -a? Приведите цитату из man по этому системному вызову, где описывается альтернативное местоположение в /proc, где можно узнать версию ядра и релиз ОС.

	Ответ:
	Linux uses the system calls sethostname(2) and setdomainname(2).  Note that there is no standard that says that
       the hostname set by sethostname(2) is the same string as the nodename field of the struct returned by  uname()  (indeed,  some
       systems allow a 256-byte hostname and an 8-byte nodename), but this is true on Linux.  The same holds for setdomainname(2) and
       the domainname field.
	Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.

7. Чем отличается последовательность команд через ; и через && в bash? Например:
root@netology1:~# test -d /tmp/some_dir; echo Hi
Hi
root@netology1:~# test -d /tmp/some_dir && echo Hi
root@netology1:~#
Есть ли смысл использовать в bash &&, если применить set -e?

	Ответ:
	1. Если команда завершается оператором управления &, оболочка выполняет команду в фоновом режиме в подоболочке. 
    Оболочка не ждет завершения команды, и статус возврата равен 0. Они называются асинхронными командами.
    2. Команды, разделенные знаком; выполняются последовательно; оболочка ожидает завершения каждой команды по очереди. 
	Статус возврата будет статус выхода последней выполненной команды.
	3. Использовать bash && c set -e не имеет смысла, так как set -e устанавливает прерывание выполнения команд при ошибке выполнения.
	
8. Из каких опций состоит режим bash set -euxo pipefail и почему его хорошо было бы использовать в сценариях?

	Ответ:
	-e - прекращает выполнение скрипта если команда завершилась ошибкой, выводит в stderr строку с ошибкой
	-u - проверяет инициализацию переменных в скрипте. Если переменной не будет, скрипт немедленно завершиться.
	-x - bash печатает в стандартный вывод все команды перед их исполнением.
	-o pipefail - прекращает выполнение скрипта, даже если одна из частей пайпа завершилась ошибкой
	Хорошо использовать в сценария из-за того что При таком запуске скрипт получается безопасным, 
	происходит автоматическая обработка ошибок и остановка скрипта при ошибках.

9. Используя -o stat для ps, определите, какой наиболее часто встречающийся статус у процессов в системе. 
В man ps ознакомьтесь (/PROCESS STATE CODES) что значат дополнительные к основной заглавной буквы статуса процессов. 
Его можно не учитывать при расчете (считать S, Ss или Ssl равнозначными).

	Ответ:
	Самые частые процессы
	S* - interruptible sleep (waiting for an event to complete)  - Процессы ожидающие завершения (спящие с прерыванием "сна")
	I* - Idle kernel thread  - Неактивный поток ядра
	R  - running or runnable (on run queue) - выполняющийся процесс, фоновый процесс
