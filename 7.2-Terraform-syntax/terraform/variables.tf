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

variable folder_id_stage {
  default = "b1gvlk8uc7e2jarkufhg"

}

variable folder_id_prod {
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

data "yandex_compute_image" "image-type" {
  family = "ubuntu-2004-lts"
}

data "yandex_compute_image" "nat-image" {
  family = "nat-instance-ubuntu"
}


variable "dns_ttl" {
  type = number
  default = 60
}

variable "dest_prefix" {
  type = string
  default = "0.0.0.0/0"
}

