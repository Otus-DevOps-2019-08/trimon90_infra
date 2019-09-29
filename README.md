# trimon90_infra
trimon90 Infra repository

# HW 3 ChatOps & Travis

Домашнее задание по теме ChatOps. Был создан канал в Slack(#ilya_manakhov), настроена синхронизация с GitHub и Travis. Был настроен Travis и создан простой пайплайн (.travis.yml), исправлена ошибка в скрипте test.py, мешавшая выкладке.

Проверить можно убедившись, что выкладка проходит по уведомлению в Slack.

# HW 4 Знакомство с обланчыми инфраструктурами

bastion_IP = 35.207.173.112
someinternalhost_IP = 10.156.0.4

Была произведена регистрация в GCP. Созданы виртальные машины bastion и someinternalhost. В качестве самостоятельной работы был написан конфиг для ssh позволяющий заходить на машину somenternalhost через bastion в одну комманду: 

```
Host bastion
  IdentityFile [Путь к ключу ssh]
  User ilya
  Hostname [Внешний ip машины bastion]
Host someinternalhost
  Hostname [Внутренний ip машины someinternalhost]
  ProxyCommand ssh bastion -W %h:%p
  LocalForward 8080 127.0.0.1:8080
```

Далее был настроен vpn сервер - pritunl. Создана организация otus и сервер otus c пользователем test. Настроен сертификт Let's encrypt.
