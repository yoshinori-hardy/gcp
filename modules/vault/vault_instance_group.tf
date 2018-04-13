resource "google_compute_region_instance_group_manager" "vault-servers" {
  region             = "${var.region}"
  name               = "vault-igm"
  base_instance_name = "vault-server"
  instance_template  = "${google_compute_instance_template.vault_instance_template.self_link}"
  target_size        = "${var.target_size}"
}
