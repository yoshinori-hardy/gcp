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
