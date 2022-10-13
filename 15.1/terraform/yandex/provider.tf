provider "yandex" {
  token = var.yc_token
  cloud_id = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone = var.yandex_compute_default_zone
}