resource "google_compute_region_instance_group_manager" "ansible-servers" {
  region             = "${var.region}"
  name               = "ansible-igm"
  base_instance_name = "ansible-server"
  instance_template  = "${google_compute_instance_template.ansible_instance_template.self_link}"
  target_size        = "${var.target_size}"
}
