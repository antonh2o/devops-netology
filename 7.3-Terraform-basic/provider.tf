# Provider
provider "yandex" {
  service_account_key_file = "/root/key.json"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
}