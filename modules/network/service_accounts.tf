resource "google_service_account" "nat-service-account" {
  account_id   = "nat-service-account"
  display_name = "nat-service-account"
}

resource "google_project_iam_binding" "nat" {
  role    = "projects/peaceful-web-200808/roles/object_ro"

  members = [
    "serviceAccount:${google_service_account.nat-service-account.email}",
  ]
}
