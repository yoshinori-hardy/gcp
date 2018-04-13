resource "google_service_account" "vault-service-account" {
  account_id   = "vault-service-account"
  display_name = "vault-service-account"
}

resource "google_project_iam_binding" "vault" {
  role    = "projects/peaceful-web-200808/roles/object_ro"

  members = [
    "serviceAccount:${google_service_account.vault-service-account.email}",
  ]
}
