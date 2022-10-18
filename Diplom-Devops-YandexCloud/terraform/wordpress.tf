#app
resource "yandex_compute_instance" "app" {
  name                      = "app"
  zone                      = "ru-central1-a"
  hostname                  = "app"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.image-type.id
      size        = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default-nat.id}"
    nat       = false
    ip_address = "${var.app_ip}"
  }

metadata = {
    user-data = "${file(".metadata")}"
  }
  scheduling_policy {
    preemptible = true
  }
}

