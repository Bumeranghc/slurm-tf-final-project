variable "image_tag" {
    type = string
    default = env("YC_IMAGE_TAG")
}

variable "YC_FOLDER_ID" {
  type = string
  default = env("YC_FOLDER_ID")
}

variable "YC_ZONE" {
  type = string
  default = env("YC_ZONE")
}

variable "YC_SUBNET_ID" {
  type = string
  default = env("YC_SUBNET_ID")
}

variable "YC_TOKEN" {
  type = string
  default = env("YC_TOKEN")
}

source "yandex" "centos" {
  folder_id           = "${var.YC_FOLDER_ID}"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  use_ipv4_nat        = "true"
  image_description   = "Slurm NGINX web server"
  image_family        = "nginx-web-server"
  image_name          = "nginx-${var.image_tag}"
  subnet_id           = "${var.YC_SUBNET_ID}"
  disk_type           = "network-hdd"
  zone                = "${var.YC_ZONE}"
  token               = "${var.YC_TOKEN}"
}

build {
  sources             = ["source.yandex.centos"]
  provisioner "ansible" {
    user          = "centos"
    playbook_file = "ansible/playbook.yml"
  }
}
