# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1gj0lmni877oia7jol4"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1gvlk8uc7e2jarkufhg"
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "centos-7-base" {
  default = "fd88d14a6790do254kj7"
}

variable "ubuntu2204-base" {
  default = "fd8autg36kchufhej85b"
}

variable "dns_ttl" {
  type = number
  default = 60
}
variable "domain" {
  type = string
  default = "antonh2o.ru"
}

variable "dest_prefix" {
  type = string
  default = "0.0.0.0/0"
}

variable "app_ip" {
  type = string
  default = "192.168.102.20"
}

variable "nginx_ip" {
  type = string
  default = "192.168.101.10"
}

variable "gitlab_ip" {
  type = string
  default = "192.168.102.28"
}

variable "runner_ip" {
  type = string
  default = "192.168.102.18"
}

variable "monitoring_ip" {
  type = string
  default = "192.168.102.38"
}

variable "db01_ip" {
  type = string
  default = "192.168.102.11"
}

variable "db02_ip" {
  type = string
  default = "192.168.102.12"
}


data "yandex_compute_image" "image-type" {
  family = "ubuntu-2004-lts"
}

data "yandex_compute_image" "nat-image" {
  family = "nat-instance-ubuntu"
}