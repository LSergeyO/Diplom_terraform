# Network
resource "yandex_vpc_network" "default" {
  name = "vpc"
}


resource "yandex_vpc_subnet" "public-a" {
  name = "subnet-a"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.100.0/24"]
}

resource "yandex_vpc_route_table" "nat" {
  name       = "route"
  network_id = "${yandex_vpc_network.default.id}"
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.100.10"
  }
}

resource "yandex_vpc_subnet" "lan-b" {
  name = "subnet-b"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.default.id}"
  route_table_id  = "${yandex_vpc_route_table.nat.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}
