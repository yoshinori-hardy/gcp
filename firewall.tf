resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "${google_compute_network.default.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["fw-ssh"]
}
