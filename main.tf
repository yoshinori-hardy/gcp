//resource "google_project" "gce-dop" {
 // name = "gce-dop"
 // project_id = "gce-dop"
//}

// main parent network {
module "build the base network"
  source       = "modules/network"
  source_image = "centos-6-v20180314"
  machine_type = "g1-small"
  region       = "europe-west2"
}

