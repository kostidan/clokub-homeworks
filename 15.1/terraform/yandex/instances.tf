data "yandex_compute_image" "ubuntu" {
  image_id = "fd80mrhj8fl2oe87o4e1"
}

resource "yandex_compute_instance" "public_instance" {
  name      = "public-instance"
  hostname    = "public.netology.cloud"

  platform_id = "standard-v1"
  
  timeouts {
    create = "60m"
    delete = "60m"
  }

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-nvme"
      size     = "50"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
    ipv6      = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("./id_rsa_netology.pub")}"
  }
}

resource "yandex_compute_instance" "private_instance" {
  name      = "private-instance"
  hostname    = "private.netology.cloud"

  platform_id = "standard-v1"

  timeouts {
    create = "60m"
    delete = "60m"
  }

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-nvme"
      size     = "50"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
    ipv6      = false
  }

  metadata = {
    ssh-keys = "ubuntu:${file("./id_rsa_netology.pub")}"
  }
}
