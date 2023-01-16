output "private_key" {
    description = "Private key to connect to instance"
    value = var.public_ssh_key_path == "" ? tls_private_key.this[0].private_key_pem : null
    sensitive = true
}

output "alb_ip" {
    description = "Public IP for ALB"
    value = yandex_alb_load_balancer.this.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

output "instances_external_ips" {
    description = "Public IP address of instances."
    value = yandex_compute_instance_group.this.instances.*.network_interface.0.nat_ip_address
}
