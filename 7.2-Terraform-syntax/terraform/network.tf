# Network
resource "yandex_vpc_network" "default" {
  name = "stage"
}

resource "yandex_vpc_route_table" "route-table" {
  name       = "route-table"
  network_id = yandex_vpc_network.default.id

#  static_route {
#    destination_prefix = var.dest_prefix
#    next_hop_address   = "192.168.101.10"
#    }

}

resource "yandex_vpc_subnet" "default" {
  name           = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}

