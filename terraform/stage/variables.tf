variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}
variable disk_image {
  description = "Disk image"
}
variable provisioner_key_path {
  description = "Path to hte public key for provisioners ssh access"
}
variable "users_ssh_keys" {
  description = "List for users ssh"
  type = list(object({
    user = string
    key  = string
  }))
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}

