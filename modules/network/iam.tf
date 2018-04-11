resource "google_service_account" "nat-service-account" {
  account_id   = "nat-service-account"
  display_name = "nat-service-account"
}

resource "google_project_iam_binding" "nat" {
  role    = "projects/admin-200808/roles/CustomNATIAMRole"

  members = [
    "serviceAccount:${google_service_account.nat-service-account.email}",
  ]
}
