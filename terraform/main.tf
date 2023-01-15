resource "local_sensitive_file" "sshkey" {
    content  = "${var.private_ssh_key_path == "" ? tls_private_key.instancekey[0].private_key_pem : file(var.private_ssh_key_path)}"
    filename = "/tmp/slurmconfigssh.pem"
    file_permission = "0400"
}

resource "yandex_iam_service_account" "this" {
  name        = "${local.prefix}vmmanager"
  description = "Service account to manage VMs"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  role = "editor"
  folder_id = var.folder_id
  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]  
}