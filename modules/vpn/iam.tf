resource "google_service_account" "vpn-service-account" {
  account_id   = "vpn-service-account"
  display_name = "vpn-service-account"
}

resource "google_project_iam_policy" "vpn-iam" {
  project     = "${var.project_id}"
  policy_data = "${data.google_iam_policy.vpn.policy_data}"
}

data "google_iam_policy" "vpn" {
  binding {
    role = "roles/vpn-role"

    members = [
      "${google_service_account.vpn-service-account.email}",
    ]
  }
}

resource "google_project_iam_custom_role" "vpn-role" {
  role_id     = "vpn-role"
  title       = "VPN IAM Role"
  description = "Security role required by VPN servers"
  permissions = ["storage.objects.get", "storage.objects.list", "compute.instances.setTags"]
}
