# trimon90_infra
trimon90 Infra repository

# HW 3 ChatOps & Travis

Домашнее задание по теме ChatOps. Был создан канал в Slack(#ilya_manakhov), настроена синхронизация с GitHub и Travis. Был настроен Travis и создан простой пайплайн (.travis.yml), исправлена ошибка в скрипте test.py, мешавшая выкладке.

Проверить можно убедившись, что выкладка проходит по уведомлению в Slack.

# HW 4 Знакомство с обланчыми инфраструктурами

```
bastion_IP = 35.207.173.112
someinternalhost_IP = 10.156.0.4
```

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


# HW 5 Основные сервисы google cloud platform

```
testapp_IP = 34.89.132.2
testapp_port = 9292

```

Была произведена настройка gcloud sdk. С помощью него создана виртуалка для приложения - reddit-app. На ней вручную были подняты ruby, mongodb; произведен деплой приложения reddit-app. Для того чтобы не производить действия руками были написаны скрипты:

 - install_ruby.sh
 - install_mongodb.sh
 - deploy.sh

Для автоматической установки и деплоя создан скрипт startup_script.sh, чтоб он запускался после создания виртуалки, нужно выполнять комманду в таком виде:

gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup_script=./startup_script.sh

Для создания нужного правила фаервола выполнить:

gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --direction INGRESS


# HW 6 Сборка образа VM при помощи Packer

Была произведена настройка packer. Создан json базового образа (reddit-base) - ubuntu16.json и образ с приложением (reddit-full) на его основе - immutable.json.

Был написан скрипт - startup_script.sh для деплоя приложения и создания системд юнита для него в образе.

Был написан скрипт create-reddit-vm.sh для создания VM из образа reddit-full.

# HW 7 Terraform

Была произведена работа по домашней работе 7, были написаны манифесты terraform для разворачмвания инфраструктуры для reddit-app.

Доп. задание 1:

- Добавление SSH-ключей к проекту.

Добавим input переменную для хранения логинов и публичных ключей в `variables.tf`:
```
variable "users_ssh_keys" {
  description = "List for users ssh"
  type = list(object({
    user = string
    key = string
  }))
}
```

Добавим пользователей с одинаковыми ключами в `terraform.tfvars`:
```
users_ssh_keys = [
  {
    user = "appuser"
    key = "путь_до_ключа"
  },
  {
    user = "appuser1"
    key = "путь до ключа"
  }
]
```

Добавим ресурс `google_compute_project_metadata_item` в `main.tf`, который будет добавлять пары `логин:ключ` в matadata проекта:
```
resource "google_compute_project_metadata_item" "ssh-keys" {
  key = "ssh-keys"
  value = join("\n", [for item in var.users_ssh_keys : "${item.user}:${file(item.key)}"])
}
```

Результат из terraform plan:
 
value   = <<~EOT

            appuser:ssh-rsa здесь_был_публичный_ключ_удален_в_целях_безопасноти appuser
            
            appuser1:ssh-rsa здесь_был_публичный_ключ_удален_в_целях_безопасноти appuser
            

Доп. задание 1.5:


Добавим юзера в веб интерфейсе, получим:


            appuser_web:ssh-rsa здесь_был_публичный_ключ_удален_в_целях_безопасноти appuser
        EOT


При выполнении `terraform apply` пользовательские SSH-ключи, добавленные через web-интерфейс, удаляются.

Доп. задание 2:

Добавим переменную `node_count` для указания количества создаваемых VM:


```
 resource "google_compute_instance" "app" {
-  name         = "reddit-app"
+  count        = var.node_count
+  name         = "reddit-app-${count.index}"
   machine_type = "g1-small"
   zone         = var.zone
```

Добавляем код для балансировщика в lb.tf

# HW 7 Terraform 2

Была произведена развибка проекта на модули - app, db. Создан модуль vpc. 

А так же на prod и stage версии.

Была освоена работа с внешним модулем storage-bucket
