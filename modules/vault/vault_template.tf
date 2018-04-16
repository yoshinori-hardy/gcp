data "template_file" "vault-start-script" {
  template = <<EOF
#!/bin/bash -eax

echo "fetch Ansible here and run it"
cd /opt && gsutil cp gs://ansible-plays/ansible-playbooks.zip .
unzip ansible-playbooks.zip
cd ansible-playbooks
echo "sleeping for 30" && sleep 30
ansible-playbook web.yml
EOF
  }

resource "google_compute_instance_template" "vault_instance_template" {
  name        = "${var.name}-${uuid()}"
  description = "This template is used to build vault Server Instances"

  tags = ["vault", "fw-ssh", "fw-http", "fw-https", "rt-int"]

  labels = {
    role = "vault"
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
    subnetwork = "${element(var.app-subnets, 1)}"
  }

  metadata {
    startup-script = "${data.template_file.vault-start-script.rendered}"
  }

  service_account {
    email = "${google_service_account.vault-service-account.email}"
    scopes = ["storage-ro"]
  }

  // Do not update if using with a managed instance group
  // see docs and ensure you understand the implications
  // before making changes here
  lifecycle {
  create_before_destroy = true
  }

}
