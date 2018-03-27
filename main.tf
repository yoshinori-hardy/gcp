//resource "google_project" "gce-dop" {
 // name = "gce-dop"
 // project_id = "gce-dop"
//}

// main parent network
resource "google_compute_network" "default" {
  name                    = "gcedop"
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
  description = "Base network to host the tool"
  project = "gcedop"
}

// configure 2 availability zones
resource "google_compute_subnetwork" "sub-europe-west2" {
  name          = "sub-europe-west2"
  ip_cidr_range = "10.1.1.0/24"
  network       = "${google_compute_network.default.self_link}"
  region        = "europe-west2"
}

resource "google_compute_subnetwork" "sub-europe-west3" {
  name          = "sub-europe-west3"
  ip_cidr_range = "10.1.2.0/24"
  network       = "${google_compute_network.default.self_link}"
  region        = "europe-west3"
}

// Obtain EIP for the NAT Instance
resource "google_compute_address" "nat-ip" {
  name = "nat-ip-1"
  region = "europe-west2"
  address_type = "EXTERNAL"
}

resource "google_compute_region_instance_group_manager" "natservers" {
  name = "natservers-igm"
  base_instance_name = "natserver"
  instance_template  = "${google_compute_instance_template.nat_instance_template.self_link}"
  region             = "europe-west2"
  target_size  = 1
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
  machine_type         = "n1-standard-1"
  depends_on = ["google_compute_address.nat-ip", "google_service_account.nat-service-account"]
  can_ip_forward       = true

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
    subnetwork = "${google_compute_subnetwork.sub-europe-west2.self_link}"
    access_config = {
      nat_ip = "${google_compute_address.nat-ip.address}"
    }
  }

  metadata {
    startup-script = "${data.template_file.nat-start-script.rendered}"
  }

  service_account {
    email = "${google_service_account.nat-service-account.email}"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only"]
  }
}
