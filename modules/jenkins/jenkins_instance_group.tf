resource "google_compute_region_instance_group_manager" "jenkins-servers" {
  name               = "jenkins-igm"
  base_instance_name = "jenkins-server"
  instance_template  = "${google_compute_instance_template.jenkins_instance_template.self_link}"
  target_size        = "${var.target_size}"
}
