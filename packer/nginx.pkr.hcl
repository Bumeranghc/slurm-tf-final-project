variable "image_name" {
    type = string
    default = env("TF_VAR_vm_image")
}

variable "image_tag" {
    type = string
    default = env("TF_VAR_vm_image_tag")
}

variable "YC_FOLDER_ID" {
  type = string
  default = env("TF_VAR_folder_id")
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
  image_name          = "${var.image_name}-${var.image_tag}"
  disk_type           = "network-hdd"
  token               = "${var.YC_TOKEN}"
}

build {
  sources             = ["source.yandex.centos"]
  provisioner "ansible" {
    user          = "centos"
    playbook_file = "ansible/playbook.yml"
  }
}
