data "yandex_compute_image" "this" {
  name = "${var.vm_image}-${var.vm_image_tag}"
  folder_id = var.folder_id
}

resource "yandex_compute_instance_group" "this" {
  name                = "${local.prefix}instance-group"
  folder_id           = "${var.folder_id}"
  service_account_id  = "${yandex_iam_service_account.this.id}"
  deletion_protection = false
  depends_on = [
    yandex_iam_service_account.this,
    yandex_resourcemanager_folder_iam_binding.this,
    yandex_vpc_subnet.this
  ]
  instance_template {
    platform_id = "standard-v1"
    resources {
      cores  = var.resources.cpu
      memory = var.resources.memory
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "${data.yandex_compute_image.this.id}"
        size     = var.resources.disk
      }
    }

    network_interface {
      network_id = "${yandex_vpc_network.this.id}"
      nat = true
    }

    labels = var.labels
    metadata = {
      ssh-keys = var.public_ssh_key_path == "" ? "centos:${tls_private_key.this[0].public_key_openssh}" : "centos:${file(var.public_ssh_key_path)}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.vm_count
    }
  }

  allocation_policy {
    zones = var.az
  }

  deploy_policy {
    max_unavailable = 3
    max_creating    = 3
    max_expansion   = 3
    max_deleting    = 3
  }

  application_load_balancer {
    target_group_name = "${local.prefix}target-group"
    target_group_description = "A target group for ALB"
    target_group_labels = var.labels
  }  
}