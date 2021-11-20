Домашнее задание к занятию «2.4. Инструменты Git

1. Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.

	Ответ:
	>git show aefea
	
		commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
		Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
		Date:   Thu Jun 18 10:29:58 2020 -0400

    		Update CHANGELOG.md

2. Какому тегу соответствует коммит 85024d3?

	Ответ:
	>git show 85024
	
		commit 85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23)
		Author: tf-release-bot <terraform@hashicorp.com>
		Date:   Thu Mar 5 20:56:10 2020 +0000

    		v0.12.23
	
3. Сколько родителей у коммита b8d720? Напишите их хеши.

	Ответ:
    с помощью git show используя формат вывода, где  --pretty %P parent hashes 
	>git show --pretty=format:" %P" b8d720

		56cd7859e05c36c06b56d013b55a252d0bb7e158 9ea88f22fc6269854151c571162c5bcf958bee2b
 
4. Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24


	Ответ:	вывожу диапазон коммитов поиском через ..
	>git log  v0.12.23..v0.12.24  --oneline

		33ff1c03b (tag: v0.12.24) v0.12.24
		b14b74c49 [Website] vmc provider links
		3f235065b Update CHANGELOG.md
		6ae64e247 registry: Fix panic when server is unreachable
		5c619ca1b website: Remove links to the getting started guide's old location
		06275647e Update CHANGELOG.md
		d5f9411f5 command: Fix bug when using terraform login on Windows
		4b6d06cc5 Update CHANGELOG.md
		dd01a3507 Update CHANGELOG.md
		225466bc3 Cleanup after v0.12.23 release

5. Найдите коммит в котором была создана функция func providerSource, 
ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).

	Ответ:
	>git log -S "func providerSource("

		commit 8c928e83589d90a031f811fae52a81be7153e82f
		Author: Martin Atkins <mart@degeneration.co.uk>
		Date:   Thu Apr 2 18:04:39 2020 -0700

    main: Consult local directories as potential mirrors of providers
	
проверил поиском в коммите нашел создание функции:
		+func providerSource(services *disco.Disco) getproviders.Source {
	+       // We're not yet using the CLI config here because we've not implemented
	+       // yet the new configuration constructs to customize provider search
	+       // locations. That'll come later.
	+       // For now, we have a fixed set of search directories:
	+       // - The "terraform.d/plugins" directory in the current working directory,

	
6. Найдите все коммиты в которых была изменена функция globalPluginDirs.

	Ответ:
	>git log -S "globalPluginDirs" --oneline

		35a058fb3 main: configure credentials from the CLI config file
		c0b176109 prevent log output during init
		8364383c3 Push plugin discovery down into command package

7. Кто автор функции synchronizedWriters?
	Ответ:
	
	Ответ: соответственно автор коммита 5ac311e2a - Martin Atkins mart@degeneration.co.uk Wed May 3 16:25:41 2017 -0700
	>git log -S "func synchronizedWriters" --pretty=format:"%h - %an %ae %ad"

		bdfea50cc - James Bardin j.bardin@gmail.com Mon Nov 30 18:02:04 2020 -0500
		5ac311e2a - Martin Atkins mart@degeneration.co.uk Wed May 3 16:25:41 2017 -0700

	где %an = author name, %ae author email, %ad = author date (format respects --date= option)
	
