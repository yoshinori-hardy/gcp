resource "google_storage_bucket" "devops-bucket" {
  name     = "${google_project.project_id.number}-bucket"
  location = "EU"
}
