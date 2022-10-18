# monitoring
resource "yandex_compute_instance" "monitoring" {
  name                      = "monitoring"
  zone                      = "ru-central1-a"
  hostname                  = "monitoring"
  allow_stopping_for_update = true

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
    ip_address = "${var.monitoring_ip}"
  }

  metadata = {
    user-data = "${file(".metadata")}"
  }
  scheduling_policy {
    preemptible = true
  }
}
