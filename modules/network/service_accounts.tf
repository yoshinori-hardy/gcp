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

resource "google_service_account" "vpn-service-account" {
  account_id   = "vpn-service-account"
  display_name = "vpn-service-account"
}

resource "google_project_iam_binding" "vpn" {
  role    = "projects/peaceful-web-200808/roles/object_ro"

  members = [
    "serviceAccount:${google_service_account.vpn-service-account.email}",
  ]
}
