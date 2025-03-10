# Helm chart for momo-store
## Установка чарта в своём кластере:
! Перед установкой чарта установите необходимые утилиты: helm, kubectl

1. Скачайте данный репозиторий: git clone  https://gitlab.praktikum-services.ru/std-ext-011-46/momo-store-chart.git

2. В кластере kubernetes необходимо самостоятельно создать ресурс ( тип Secret ) содержащий параметры подключения к вашему docker registry gitlab'a:
Измените в файле __dockerconfigjson.yaml__ строку '<base64 encoded docker secret>' на валидный конфиг для подключения к docker-registry (https://clck.ru/3H6XKi) закодированный в формате base64: 
	1) декодируйте конфиг: 'ewoJImF1dGhzIjogewoJCSJnaXRsYWIucHJha3Rpa3VtLXNlcnZpY2VzLnJ1OjUwNTAiOnsKCQkJImF1dGgiOiAiUEd4dloybHVPbkJoYzNOM2IzSmtQZz09IgoJCX0KCX0KfQ==' 
	2) декодируйте строку: 'PGxvZ2luOnBhc3N3b3JkPg==' 
	3) замените её на ваши значения, закодируйте и подставьте обратно в конфиг 
	4) закодируйте конфиг и подставьте получившуюся строку за  место '<base64 encoded docker secret>' 
	5) замените '<secret-name>' на любое имя и не забудьте его так же изменить в файле __values.yaml__: global.backend.docker_secret_name и global.frontend.docker_secret_name 
	6) создайте ресурс: `kubectl apply -f dockerconfigjson.yaml`

3. В файле __values.yaml__ измените параметры global.backend.version и global.frontend.version на значения версий из вашего репозитория с кодом.

4. Установите чарт и следуйте дальнейшим инструкциям: `helm install momo-store ./charts -n momo-namespace --atomic`
	Важно! устанваливайте чарт в новый namespace. Сервисы для сбора метрик prometheus и grafana устанавливаются с помощью хуков, чтобы быть логически независимыми развёртываниями от основного чарта. При удалении чарта, эти ресурсы не удалятся вместе с основным чартом, их придётся удалять вручную!

После этих шагов фронтенд должен отвечать через браузер, grafana должна быть так же сразу доступна, никакой дополнительной конфигурации не требуется.

## Создание пайплайна для сборки и хранения чартов
1. Создайте свой репозиторий в gitlab.praktikum-services.ru, но оставьте его пустым на этом этапе, иначе после загрузки сразу запустятся пайплайны, а нам нужно ещё изменить некоторые значения в values.yaml и создать некоторые секреты в gitlab'e и кубернетисе. Не хотим же мы иметь неработающий пайлайн.
2. Создайте Nexus-репозиторий https://nexus.praktikum-services.tech/ тип: helm hosted, Deployment policy: allow redeploy, добавьте в gitlab следующие секреты:
"NEXUS_HELM_REPO": "https://nexus.praktikum-services.tech/repository/your-nexus-repo-name/"
"NEXUS_HELM_REPO_USERNAME":""
"NEXUS_HELM_REPO_PASSWORD":""
3. Загрузите текущий локальный репозиторий в gitlab.praktikum-services.ru


