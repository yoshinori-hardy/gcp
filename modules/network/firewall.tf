resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "${google_compute_network.dop-vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["fw-ssh"]
}

resource "google_compute_firewall" "allow-http" {
  name    = "allow-http"
  network = "${google_compute_network.dop-vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["fw-http"]
}

resource "google_compute_firewall" "allow-https" {
  name    = "allow-https"
  network = "${google_compute_network.dop-vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags = ["fw-https"]
}
