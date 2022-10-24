resource "yandex_compute_instance" "vm" {
  zone                      = "ru-central1-a"
  name                      = "vm"
  hostname                  = "antonh2o.ru"
  allow_stopping_for_update = true

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

