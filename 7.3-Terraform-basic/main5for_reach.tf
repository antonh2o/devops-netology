locals {
  stage = toset (["1"])
  prod  = toset (["1", "2"])
}
resource "yandex_compute_instance" "vmforeach" {
  zone                      = "ru-central1-a"
  platform_id = "${terraform.workspace == "stage" ? "standard-v1" : terraform.workspace == "prod" ? "standard-v2" : "standard-v1" }"
  for_each = "${terraform.workspace == "stage" ? local.stage : terraform.workspace == "prod" ? local.prod : local.stage}"
  name = "vm-4reach-${each.key}-${terraform.workspace}"
  allow_stopping_for_update = true

  lifecycle {
    create_before_destroy = true
  }
  resources {
    core_fraction = 5
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.nat-image.id
      size        = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    user-data = "${file(".metadata")}"
  }
  scheduling_policy {
    preemptible = true
  }

}