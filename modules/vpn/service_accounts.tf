resource "google_service_account" "vpn-service-account" {
  account_id   = "vpn-service-account"
  display_name = "vpn-service-account"
}

resource "google_project_iam_binding" "vpn" {
  role    = "projects/admin-200808/roles/object-ro"

  members = [
    "serviceAccount:${google_service_account.vpn-service-account.email}",
  ]
}
