data "template_file" "jenkins-start-script" {
  template = <<EOF
#!/bin/bash -eax

echo "fetch Ansible here and run it"
EOF
  }

resource "google_compute_instance_template" "jenkins_instance_template" {
  name        = "jenkins-instance-template"
  description = "This template is used to build Jenkins Server Instances"

  tags = ["jenkins", "fw-ssh", "fw-http"]

  labels = {
    role = "jenkins"
  }

  instance_description = "Built using TF instance template"
  machine_type         = "g1-small"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "${var.source_image}"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = "${element(var.app-subnets, 0)}"
    access_config = {
      # nat_ip = "${google_compute_address.nat-ip.address}"
    }
  }

  metadata {
    startup-script = "${data.template_file.jenkins-start-script.rendered}"
  }

  service_account {
    email = "${google_service_account.jenkins-service-account.email}"
    scopes = ["storage-ro"]
  }

  // Do not update if using with a managed instance group
  // see docs and ensure you understand the implications
  // before making changes here
  lifecycle {
  create_before_destroy = true
  }

}
