data "template_file" "web-start-script" {
  template = <<EOF
#!/bin/bash -eax

source /etc/profile.d/python27.sh

cd /opt && gsutil cp gs://yoshops/ansible-playbooks.zip .
unzip ansible-playbooks.zip
cd ansible-playbooks
echo "sleeping for 30" && sleep 30
ansible-playbook web.yml
EOF
  }

resource "google_compute_instance_template" "web_instance_template" {
  name        = "web-instance-template"
  description = "This template is used to build WEB Server Instances"

  tags = ["web", "dev", "http-server"]

  labels = {
    environment = "dev"
    product = "sandbox"
    role = "web-server"
  }

  instance_description = "Built using TF instance template"
  machine_type         = "n1-standard-1"
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
    subnetwork = "https://www.googleapis.com/compute/v1/projects/mindful-faculty-196010/regions/europe-west1/subnetworks/eu-west-1-dmz"
    access_config = {
      #nat_ip = "${google_compute_address.nat-ip.address}"
    }
  }

  metadata {
    foo = "bar"
    startup-script = "${data.template_file.web-start-script.rendered}"
  }

  service_account {
    email = "instance-role@mindful-faculty-196010.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  // Do not update if using with a managed instance group
  // see docs and ensure you understand the implications
  // before making changes here
  lifecycle {
  create_before_destroy = true
  }

}
