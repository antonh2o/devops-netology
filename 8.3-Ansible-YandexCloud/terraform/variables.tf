# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1......l4"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1......hg"
}

variable "instance_cores" {
  default = "2"
}

variable "instance_memory" {
  default = "2"
}


# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "centos-7" {
  default = "fd8p7vi5c5bbs2s5i67s"
}

data "yandex_compute_image" "image-type" {
  family = "ubuntu-2004-lts"
}

data "yandex_compute_image" "nat-image" {
  family = "nat-instance-ubuntu"
}