provider "google" {
  version = "~> 2.15"
  project = var.project
  region  = var.region
}
module "storage-bucket" {
  source  = "SweetOps/storage-bucket/google"
  version = "0.3.0"
  # Имена поменяйте на другие
  name = "storage-bucket-otus-trimon90"
}
output storage-bucket_url {
  value = module.storage-bucket.url
}

