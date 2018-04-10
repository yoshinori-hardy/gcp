resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "${google_compute_network.gcpdop.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["fw-ssh"]
}

resource "google_compute_firewall" "vpn" {
  name    = "allow-vpn"
  network = "${google_compute_network.gcpdop.name}"

  allow {
    protocol = "udp"
    ports    = ["500", "4500"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["fw-vpn"]
}
