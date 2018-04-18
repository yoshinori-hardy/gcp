
output "dop-vpc" {
  value = "${google_compute_network.dop-vpc.self_link}"
}

output "dmz-subnet" {
  value = "${google_compute_subnetwork.sub-dmz.self_link}"
}

output "sub-map" {
  value = "${zipmap(
    google_compute_subnetwork.sub-app.*.name, google_compute_subnetwork.sub-app.*.self_link
  )}"
}

