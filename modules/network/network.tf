resource "google_compute_network" "dop-vpc" {
  name                    = "dop-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
  description             = "Base network to host the platform"
}

// configure subnets 1 internal 1 internet facing
resource "google_compute_subnetwork" "sub-dmz" {
  name                    = "sub-dmz"
  ip_cidr_range           = "${var.subnet_dmz}"
  network                 = "${google_compute_network.dop-vpc.self_link}"
  region                  = "${var.region}"
}

resource "google_compute_subnetwork" "sub-app" {
  name                    = "sub-app"
  ip_cidr_range           = "${var.subnet_app}"
  network                 = "${google_compute_network.dop-vpc.self_link}"
  region                  = "${var.region}"
}
