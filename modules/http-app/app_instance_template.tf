data "template_file" "app-start-script" {
  template = <<EOF
#!/bin/bash -eax

echo "fetch Ansible here and run it"
cd /opt && gsutil cp gs://ansible-plays/ansible-playbooks.zip .
unzip ansible-playbooks.zip
cd ansible-playbooks
echo "${var.name}"
echo "sleeping for 30" && sleep 30
ansible-playbook "${var.name}".yml
EOF

}

resource "google_compute_instance_template" "app_instance_template" {
  name        = "${var.name}-${uuid()}"
  description = "This template is used to build Application Server Instances"

  tags = ["${var.name}", "fw-ssh", "fw-http", "fw-https", "rt-int"]

  labels = {
    role = "${var.name}"
  }

  instance_description = "Built using TF instance template"
  machine_type         = "${var.machine_type}"
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
    disk_size_gb = "${var.disk_size_gb}"
  }

  network_interface {
    subnetwork = "${var.sub-map["${var.name}"]}"
  }

  metadata {
    startup-script = "${data.template_file.app-start-script.rendered}"
  }

  service_account {
    email = "${google_service_account.app-service-account.email}"
    scopes = ["storage-ro"]
  }

  // Do not update if using with a managed instance group
  // see docs and ensure you understand the implications
  // before making changes here
  lifecycle {
  create_before_destroy = true
  }

}
