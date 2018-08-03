resource "google_service_account" "app-service-account" {
  account_id   = "${var.name}-service-account"
  display_name = "${var.name}-service-account"
}

resource "google_project_iam_binding" "app-iam-link" {
  role    = "projects/xxxxxxxxxx/roles/object_ro"

  members = [
    "serviceAccount:${google_service_account.app-service-account.email}",
  ]
}
