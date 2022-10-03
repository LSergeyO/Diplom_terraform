# Provider

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.78"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "devops-lso"
    region     = "ru-central1"
    key        = "terraform/infrastructure/terraform.tfstate"
    access_key = "YCAJEPzt9Lq36pj2zgP9ZRrWQ"
    secret_key = "YCNyXWftjaJeEp95diK6A-278yEu4XEBXUkr3EOn"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = "AQAAAAAL203tAATuwd6joms4lE7tsV-DqsaL9-w"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
  zone      = "ru-central1-a"
}


