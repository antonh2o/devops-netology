resource "yandex_compute_instance" "db01" {
  name     = "db01"
  zone     = "ru-central1-a"
  hostname = "db01"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.image-type.id
      size        = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default-nat.id}"
    nat       = false
    ip_address = "192.168.102.11"
  }

  metadata = {
    user-data = "${file(".metadata")}"
  }
  scheduling_policy {
    preemptible = true
  }

}

# db02
resource "yandex_compute_instance" "db02" {
  name     = "db02"
  zone     = "ru-central1-a"
  hostname = "db02"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.image-type.id
      size        = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default-nat.id}"
    nat       = false
    ip_address = "192.168.102.12"

  }

  metadata = {
    user-data = "${file(".metadata")}"
  }
  scheduling_policy {
    preemptible = true
  }
}