terraform {
required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    bucket     = "antonh2obackend"
    endpoint   = "storage.yandexcloud.net"
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = "YC...текст изменен...UH"
    secret_key = "YC...текст изменен...oP_vy...текст изменен...sA"

    shared_credentials_file = "~/.aws/config"
    profile    =  "netology"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
