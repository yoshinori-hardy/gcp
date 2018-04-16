resource "google_compute_region_instance_group_manager" "app-servers" {
  region             = "${var.region}"
  name               = "${var.name}-igm"
  base_instance_name = "${var.name}-server"
  instance_template  = "${google_compute_instance_template.app_instance_template.self_link}"
  target_size        = "${var.target_size}"
}
