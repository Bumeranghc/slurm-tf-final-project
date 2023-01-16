terraform {
  required_providers {
    yandex = {
      source    = "yandex-cloud/yandex"
    }
    tls = {
      source    = "hashicorp/tls"
      version   = "4.0.4"
    }
    local = {
      source    = "hashicorp/local"
      version   = "2.2.3"
    }
  }
  required_version = ">= 0.13"
}
