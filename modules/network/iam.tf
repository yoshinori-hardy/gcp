resource "google_service_account" "nat-service-account" {
  account_id   = "nat-service-account"
  display_name = "nat-service-account"
}

resource "google_project_iam_policy" "nat-iam" {
  depends_on  = ["google_service_account.nat-service-account"]
  policy_data = "${data.google_iam_policy.nat.policy_data}"
}

data "google_iam_policy" "nat" {
  binding {
    role = "roles/CustomNATIAMRole"

    members = [
      "serviceAccount:${google_service_account.nat-service-account.email}",
    ]
  }
}
