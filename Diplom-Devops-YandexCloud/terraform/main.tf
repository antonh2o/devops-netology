#revproxy nginx
resource "yandex_compute_instance" "nginx" {
  name                      = "nginx"
  zone                      = "ru-central1-a"
  hostname                  = "antonh2o.ru"
  allow_stopping_for_update = true


  resources {
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
    ip_address = "${var.nginx_ip}"
  }

  metadata = {
    user-data = "${file(".metadata")}"
  }
  scheduling_policy {
    preemptible = true
  }
}
