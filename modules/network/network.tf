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
  count                   = 3
  name                    = "sub-app-${count.index}"
  ip_cidr_range           = "${var.subnets[count.index]}"
  network                 = "${google_compute_network.dop-vpc.self_link}"
  region                  = "${var.region}"
}
