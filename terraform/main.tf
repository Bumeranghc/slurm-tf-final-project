resource "yandex_iam_service_account" "this" {
  name        = "${local.prefix}vmmanager"
  description = "Service account to manage VMs"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  role      = "editor"
  folder_id = var.folder_id
  members   = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]  
}