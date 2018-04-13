resource "google_service_account" "jenkins-service-account" {
  account_id   = "jenkins-service-account"
  display_name = "jenkins-service-account"
}

resource "google_project_iam_binding" "jenkins" {
  role    = "projects/peaceful-web-200808/roles/object_ro"

  members = [
    "serviceAccount:${google_service_account.jenkins-service-account.email}",
  ]
}
