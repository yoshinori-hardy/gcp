resource "google_project" "gcedop" {
  name = "gcedop"
  project_id = "gcedop"
}

// main parent network
module "build the VPC and NAT" {
  source       = "modules/network"
  source_image = "centos-6-v20180314"
  machine_type = "g1-small"
  region       = "europe-west2"
  subnet_1     = "10.1.1.0/24"
  subnet_2     = "10.1.2.0/24"
}
