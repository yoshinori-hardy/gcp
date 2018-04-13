resource "google_compute_route" "nat-gw-route" {
  depends_on  = ["google_compute_subnetwork.sub-dmz"]
  name        = "nat-gw-route"
  dest_range  = "0.0.0.0/0"
  network     = "${google_compute_network.dop-vpc.self_link}"
  next_hop_ip = "${var.nat-int-ip}"
  priority    = 800
  tags        = ["rt-int"]
}

