resource "yandex_alb_backend_group" "this" {
  name          = "${local.prefix}alb-backend-group"

  http_backend {
    name        = "${local.prefix}backend"
    weight      = 1
    port        = 80
    target_group_ids = ["${yandex_compute_instance_group.this.application_load_balancer[0].target_group_id}"]
    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck {
      timeout   = "1s"
      interval  = "1s"
      http_healthcheck {
        path    = "/"
      }
    }
    http2       = "false"
  }
}

resource "yandex_alb_http_router" "this" {
  name          = "${local.prefix}alb-http-router"
  folder_id     = var.folder_id
  labels        = var.labels
}

resource "yandex_alb_virtual_host" "this" {
  name          = "albhost"
  http_router_id = yandex_alb_http_router.this.id
  route {
    name        = "albroute"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
        timeout = "15s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "this" {
  name          = "alb"

  network_id    = yandex_vpc_network.this.id

  allocation_policy {
    dynamic "location" {
        for_each = toset(var.az)
        content {
            zone_id     = location.value
            subnet_id   = yandex_vpc_subnet.this[location.value].id 
        }
    }
  }

  listener {
    name = "alblistener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id  = yandex_alb_http_router.this.id
      }
    }
  }
}