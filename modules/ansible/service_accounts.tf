resource "google_service_account" "ansible-service-account" {
  account_id   = "ansible-service-account"
  display_name = "ansible-service-account"
}

resource "google_project_iam_binding" "ansible" {
  role    = "projects/peaceful-web-200808/roles/object_ro"

  members = [
    "serviceAccount:${google_service_account.ansible-service-account.email}",
  ]
}
