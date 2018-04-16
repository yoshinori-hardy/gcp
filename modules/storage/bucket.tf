resource "google_storage_bucket" "devops-bucket" {
  name     = "bucket-${uuid()}"
  location = "EU"
}
