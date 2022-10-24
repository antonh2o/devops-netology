output "vm" {
  value = "${yandex_compute_instance.vm.network_interface.0.ip_address}"
  depends_on = [
    yandex_compute_instance.vm,
  ]

}

output "yandex_compute_image" {
  value = data.yandex_compute_image.image-type.id
}

data "yandex_client_config" "client" {}
output "zone" {
  value = data.yandex_client_config.client.zone
}
output "cloud_id" {
  value = data.yandex_client_config.client.cloud_id
}
output "folder_id" {
  value = data.yandex_client_config.client.folder_id
}