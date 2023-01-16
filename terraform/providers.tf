terraform {
  required_providers {
    yandex = {
      source    = "yandex-cloud/yandex"
    }
    tls = {
      source    = "hashicorp/tls"
      version   = "4.0.4"
    }
  }
  required_version = ">= 0.13"
}
