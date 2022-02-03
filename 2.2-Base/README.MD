### Домашнее задание к занятию «2.2. Основы Git»

## Задание №1 – Знакомимся с gitlab и bitbucket
Иногда при работе с git-репозиториями надо настроить свой локальный репозиторий так, чтобы можно было отправлять и принимать изменения из нескольких удалённых репозиториев. Это может понадобиться при работе над проектом с открытым исходным кодом, если автор проекта не дает права на запись в основной репозиторий. Либо некоторые распределенные команды используют такой принцип работы, когда каждый разработчик имеет свой репозиторий, а в основной репозиторий пушатся только конечные результаты работы над задачами.

Так же у DevOps-специалиста должен быть хороший кругозор, поэтому давайте познакомимся с gitlab и bitbucket.

Создадим аккаунт в gitlab, если у вас его еще нет:

Gitlab. Страница регистрации https://gitlab.com/users/sign_up, для регистрации можно использовать аккаунт google, github и другие.
После регистрации или авторизации в gitlab создайте новый проект, нажав на ссылку Create a projet. Желательно назвать также, как и в гитхабе devops-netology и visibility level выбрать Public.
Галочку Initialize repository with a README луше не ставить, чтобы не пришлось разрешать конфликты.
Если вы зарегистрировались при помощи аккаунта в другой системе и не указали пароль, то увидите сообщение You won't be able to pull or push project code via HTTPS until you set a password on your account. Тогда перейдите по ссылке из этого сообщения (https://gitlab.com/profile/password/edit) и задайте пароль. Если вы уже умеете пользоваться ssh ключами, то воспользуйтесь этой возможностью (подробнее про ssh мы поговорим в следующем учебном блоке).
Перейдите на страницу созданного вами репозитория, url будет примерно такой: https://gitlab.com/YOUR_LOGIN/devops-netology и изучите предлагаемые варианты для начала работы в репозитории в секции Command line instructions.
Запомните вывод команды git remote -v.
В связи с тем, что это будет наш дополнительный репозиторий, ни один вариант из перечисленных в инструкции (на странице вновь созданного репозитория) нам не подходит. Поэтому добавляем этот репозиторий как дополнительный remote к созданному репозиторию в рамках предыдущего домашнего задания: git remote add gitlab https://gitlab.com/YOUR_LOGIN/devops-netology.git.
Отправьте изменения в новый удалённый репозиторий git push -u gitlab main.
Обратите внимание как изменился результат работы команды git remote -v.
Теперь необходимо проделать все тоже самое с https://bitbucket.org/.

Обратите внимание, что репозиторий должен быть публичным, то есть отключите галочку private repository при создании репозитория.
И на вопрос Include a README? отвечаем отказом.
В отличии от гитхаба и гитлаба, в битбакете репозиторий должен принадлежать проекту, поэтому во время создания репозитория надо создать и проект, который можно назвать, например, netology.
Аналогично gitlab, на странице вновь созданного проекта выберите https, чтобы получить ссылку и добавьте этот репозиторий как git remote add bitbucket ....
Обратите внимание, как изменился результат работы команды git remote -v.
Если все проделано правильно, то результат команды git remote -v должен быть следующий:

$ git remote -v
bitbucket https://andreyborue@bitbucket.org/andreyborue/devops-netology.git (fetch)
bitbucket https://andreyborue@bitbucket.org/andreyborue/devops-netology.git (push)
gitlab	  https://gitlab.com/andrey.borue/devops-netology.git (fetch)
gitlab	  https://gitlab.com/andrey.borue/devops-netology.git (push)
origin	  https://github.com/andrey-borue/devops-netology.git (fetch)
origin	  https://github.com/andrey-borue/devops-netology.git (push)
Дополнительно можете так же добавить удалённые репозитории по ssh, тогда результат будет примерно такой:

git remote -v
bitbucket	git@bitbucket.org:andreyborue/devops-netology.git (fetch)
bitbucket	git@bitbucket.org:andreyborue/devops-netology.git (push)
bitbucket-https	https://andreyborue@bitbucket.org/andreyborue/devops-netology.git (fetch)
bitbucket-https	https://andreyborue@bitbucket.org/andreyborue/devops-netology.git (push)
gitlab	git@gitlab.com:andrey.borue/devops-netology.git (fetch)
gitlab	git@gitlab.com:andrey.borue/devops-netology.git (push)
gitlab-https	https://gitlab.com/andrey.borue/devops-netology.git (fetch)
gitlab-https	https://gitlab.com/andrey.borue/devops-netology.git (push)
origin	git@github.com:andrey-borue/devops-netology.git (fetch)
origin	git@github.com:andrey-borue/devops-netology.git (push)
origin-https	https://github.com/andrey-borue/devops-netology.git (fetch)
origin-https	https://github.com/andrey-borue/devops-netology.git (push)
Выполните push локальной ветки main в новые репозитории. Подсказка: git push -u gitlab main. На этом этапе история коммитов во всех трех репозиториях должна совпадать.

Задание №2 – Теги
Представьте ситуацию, когда в коде была обнаружена ошибка - надо вернуться на предыдущую версию кода, исправить ее и выложить исправленный код в продакшн. Мы никуда код выкладывать не будем, но пометим некоторые коммиты тегами и создадим от них ветки.

Создайте легковестный тег v0.0 на HEAD коммите и запуште его во все три добавленных на предыдущем этапе upstream.
Аналогично создайте аннотированный тег v0.1.
Перейдите на страницу просмотра тегов в гитхабе (и в других репозиториях) и посмотрите, чем отличаются созданные теги.
В гитхабе – https://github.com/YOUR_ACCOUNT/devops-netology/releases
В гитлабе – https://gitlab.com/YOUR_ACCOUNT/devops-netology/-/tags
В битбакете – список тегов расположен в выпадающем меню веток на отдельной вкладке.
Задание №3 – Ветки
Давайте посмотрим, как будет выглядеть история коммитов при создании веток.

Переключитесь обратно на ветку main, которая должна быть связана с веткой main репозитория на github.
Посмотрите лог коммитов и найдите хеш коммита с названием Prepare to delete and move, который был создан в пределах предыдущего домашнего задания.
Выполните git checkout по хешу найденного коммита.
Создайте новую ветку fix базируясь на этом коммите git switch -c fix.
Отправьте новую ветку в репозиторий на гитхабе git push -u origin fix.
Посмотрите, как визуально выглядит ваша схема коммитов: https://github.com/YOUR_ACCOUNT/devops-netology/network.
Теперь измените содержание файла README.md, добавив новую строчку.
Отправьте изменения в репозиторий и посмотрите, как изменится схема на странице https://github.com/YOUR_ACCOUNT/devops-netology/network и как изменится вывод команды git log.
Задание №4 – Упрощаем себе жизнь
Давайте попробуем поработь с Git при помощи визуального редактора.

В используемой нами IDE Py Charm откройте визуальный редактор работы с git, находящийся в меню View -> Tool Windows -> Git.
Измените какой-нибудь файл, и он сразу появится на вкладке Local Changes, отсюда можно выполнить коммит нажав на кнопку внизу этого диалога.
Элементы управления для работы с гитом будут выглядеть примерно вот так: Работа с гитом
Попробуйте выполнить пару коммитов используя IDE.
