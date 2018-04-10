resource "google_service_account" "nat-service-account" {
  account_id   = "nat-service-account"
  display_name = "nat-service-account"
}

resource "google_project_iam_policy" "nat-iam" {
  project     = "${var.project_id}"
  policy_data = "${data.google_iam_policy.nat.policy_data}"
}

data "google_iam_policy" "nat" {
  binding {
    role = "roles/nat-role"

    members = [
      "${google_service_account.nat-service-account.email}",
    ]
  }
}

resource "google_project_iam_custom_role" "nat-role" {
  role_id     = "nat-role"
  title       = "NAT IAM Role"
  description = "Security role required by NAT servers"
  permissions = ["storage.objects.get", "storage.objects.list", "compute.instances.setTags"]
}
