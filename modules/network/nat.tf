// Obtain EIP for the NAT Instance
resource "google_compute_address" "nat-ip" {
  name = "nat-ip-1"
  region = "${var.region}"
  address_type = "EXTERNAL"
}

resource "google_compute_region_instance_group_manager" "natservers" {
  name = "natservers-igm"
  base_instance_name = "natserver"
  instance_template  = "${google_compute_instance_template.nat_instance_template.self_link}"
  region             = "${var.region}"
  target_size  = 1

  provisioner "local-exec" {
    when    = "destroy"
    command = "${var.local_cmd_destroy}"
    interpreter = ["sh", "-c"]
  }

  provisioner "local-exec" {
    when        = "create"
    command     = "${var.local_cmd_create}"
    interpreter = ["sh", "-c"]
  }
}

data "template_file" "nat-start-script" {
  template = <<EOF
#!/bin/bash -eax
sudo service iptables start
sudo chkconfig iptables on
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
EOF
  }

resource "google_compute_instance_template" "nat_instance_template" {
  name        = "nat-instance-template"
  depends_on = ["google_service_account.nat-service-account"]
  description = "This template is used to build NAT Instances"

// add project ID to the tags?
  tags = ["nat", "fw-ssh"]

  labels = {
    role = "nat-services"
  }

  instance_description = "Built using TF instance template"
  machine_type         = "${var.machine_type}"
  depends_on = ["google_compute_address.nat-ip", "google_service_account.nat-service-account"]
  can_ip_forward       = "${var.can_ip_forward}"

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
    subnetwork = "${google_compute_subnetwork.sub-dmz.self_link}"
    address    = "${var.nat-int-ip}"
    access_config = {
      nat_ip = "${google_compute_address.nat-ip.address}"
    }
  }

  metadata {
    startup-script = "${data.template_file.nat-start-script.rendered}"
  }

  service_account {
    email = "${google_service_account.nat-service-account.email}"
    scopes = ["storage-ro"]
  }
}

