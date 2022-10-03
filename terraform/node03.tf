resource "yandex_compute_instance" "db02" {
  name                      = "db02"
  zone                      = "ru-central1-b"
  hostname                  = "db02"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "fd8uoiksr520scs811jl"
      name        = "root-db02"
      type        = "network-ssd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id  = "${yandex_vpc_subnet.lan-b.id}"
    ip_address = "192.168.101.12"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

}
