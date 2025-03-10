# Helm chart for momo-store
## Создание пайплайна для сборки и хранения чартов

1. Склонируйте данный репозиторий: git clone  https://gitlab.praktikum-services.ru/std-ext-011-46/momo-store-chart.git

2. Создайте Nexus-репозиторий https://nexus.praktikum-services.tech/ тип: helm hosted, Deployment policy: allow redeploy.

3. Добавьте в gitlab следующие секреты:
"NEXUS_HELM_REPO": "https://nexus.praktikum-services.tech/repository/your-nexus-repo-name/",
"NEXUS_HELM_REPO_USERNAME":"",
"NEXUS_HELM_REPO_PASSWORD":"",
"KUBECONFIG_USER_TOKEN":"",
"KUBECONFIG_CONTEXT_NAMESPACE":"",
"KUBECONFIG_CLUSTER_CONTROLPLANE_ADDRESS":"",
"KUBECONFIG_CLUSTER_CERTIFICATE_AUTHORITY_DATA":"",
"DOCKER_REGISTRY_URL":"gitlab.praktikum-services.ru",
"DOCKER_REGISTRY_PORT":"5050",
"DOCKER_REGISTRY_USERNAME":"",
"DOCKER_REGISTRY_PASSWORD":"",


3. Загрузите текущий локальный репозиторий в gitlab.praktikum-services.ru

## Установка чарта в своём кластере:
> [!NOTE]  
> Перед установкой чарта установите необходимые утилиты: __helm__, __kubectl__

1. Скачайте данный репозиторий: git clone  https://gitlab.praktikum-services.ru/std-ext-011-46/momo-store-chart.git

2. В кластере kubernetes необходимо самостоятельно создать ресурс ( тип Secret ) содержащий параметры подключения к вашему docker registry gitlab'a:
Измените в файле __dockerconfigjson.yaml__ строку 'base64 encoded docker secret' на валидный конфиг для подключения к docker-registry (https://clck.ru/3H6XKi) закодированный в формате base64: 
	1) декодируйте конфиг: 'ewoJImF1dGhzIjogewoJCSJnaXRsYWIucHJha3Rpa3VtLXNlcnZpY2VzLnJ1OjUwNTAiOnsKCQkJImF1dGgiOiAiUEd4dloybHVPbkJoYzNOM2IzSmtQZz09IgoJCX0KCX0KfQ==' 
	2) декодируйте строку: 'PGxvZ2luOnBhc3N3b3JkPg==' 
	3) замените её на ваши значения, закодируйте и подставьте обратно в конфиг 
	4) закодируйте конфиг и подставьте получившуюся строку за  место 'base64 encoded docker secret' 
	5) замените 'secret-name' на любое имя __и не забудьте__ его так же изменить в файле __values.yaml__: global.backend.docker_secret_name и global.frontend.docker_secret_name !
	6) создайте ресурс: `kubectl apply -f dockerconfigjson.yaml`

3. В файле __values.yaml__ измените параметры global.backend.version и global.frontend.version на значения версий из вашего репозитория с кодом.

4. Установите чарт и следуйте дальнейшим инструкциям: `helm install momo-store ./charts -n momo-namespace --atomic`
> [!TIP] 
> Устанваливайте чарт в новый namespace. Сервисы для сбора метрик prometheus и grafana устанавливаются с помощью хуков, чтобы быть логически независимыми развёртываниями от основного чарта. При удалении чарта, эти ресурсы не удалятся вместе с основным чартом, их придётся удалять вручную!

После этих шагов фронтенд должен отвечать через браузер, grafana должна быть так же сразу доступна, никакой дополнительной конфигурации не требуется.


