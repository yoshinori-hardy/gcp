// Obtain EIP for the VPN Instance
//resource "google_compute_address" "nat-ip" {
//  name = "nat-ip-1"
//  region = "${var.region}"
//  address_type = "EXTERNAL"
//}

resource "google_compute_region_instance_group_manager" "vpnservers" {
  name = "vpnservers-igm"
  base_instance_name = "vpnserver"
  instance_template  = "${google_compute_instance_template.vpn_instance_template.self_link}"
  region             = "${var.region}"
  target_size  = 1
}

data "template_file" "vpn-start-script" {
  template = <<EOF
#!/bin/bash -eax

sudo service iptables start
sudo chkconfig iptables on
sysctl -w net.ipv4.ip_forward=1
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
EOF
  }

resource "google_compute_instance_template" "vpn_instance_template" {
  name        = "vpn-instance-template"
  depends_on = ["google_service_account.vpn-service-account"]
  description = "This template is used to build VPN Instances"

// add project ID to the tags?
  tags = ["nat", "fw-ssh", "fw-vpn"]

  labels = {
    role = "vpn-services"
  }

  instance_description = "Built using TF instance template"
  machine_type         = "${var.machine_type}"
//  depends_on = ["google_compute_address.vpn-ip", "google_service_account.vpn-service-account"]
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
    subnetwork = "${google_compute_subnetwork.sub-dmz.self_link}"
    access_config = {
      vpn_ip = "${google_compute_address.vpn-ip.address}"
    }
  }

  metadata {
    startup-script = "${data.template_file.vpn-start-script.rendered}"
  }

  service_account {
    email = "${google_service_account.vpn-service-account.email}"
  }
}
