data "template_file" "ansible-start-script" {
  template = <<EOF
#!/bin/bash -eax

echo "fetch Ansible here and run it"
EOF
  }

resource "google_compute_instance_template" "ansible_instance_template" {
  name        = "ansible-instance-template"
  description = "This template is used to build ansible Server Instances"

  tags = ["ansible", "fw-ssh", "fw-http", "fw-https", "rt-int"]

  labels = {
    role = "ansible"
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

  disk {
    auto_delete  = true
    boot         = false
    disk_size_gb = "20"
  }

  network_interface {
    subnetwork = "${element(var.app-subnets, 2)}"
  }

  metadata {
    startup-script = "${data.template_file.ansible-start-script.rendered}"
  }

  service_account {
    email = "${google_service_account.ansible-service-account.email}"
    scopes = ["storage-ro"]
  }

  // Do not update if using with a managed instance group
  // see docs and ensure you understand the implications
  // before making changes here
  lifecycle {
  create_before_destroy = true
  }

}
