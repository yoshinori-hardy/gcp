resource "google_compute_network" "dop-vpc" {
  name                    = "${var.project}-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
  description             = "Base network to host the platform"
  project                 = ${google_project.gcedop.self_link}"
}

// configure subnets 1 internal 1 internet facing
resource "google_compute_subnetwork" "sub-dmz" {
  name                    = "${var.project}-sub-dmz"
  ip_cidr_range           = "${var.subnet_1}"
  network                 = "${google_compute_network.default.self_link}"
  region                  = "${var.region}"
}

resource "google_compute_subnetwork" "sub-app" {
  name                    = "${var.project}-sub-app"
  ip_cidr_range           = "${var.subnet_2}"
  network                 = "${google_compute_network.default.self_link}"
  region                  = "${var.region}"
}
