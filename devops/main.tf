//resource "google_project" "gcpdop" {
//  name = "gcpdop"
//  project_id = "gcpdop"
//}

module "build_the_vpc" {
  source       = "../modules/network"
  source_image = "centos-6-v20180314"
  machine_type = "g1-small"
  region       = "europe-west2"
  subnet_dmz   = "10.1.1.0/24"
  subnet_app   = "10.1.2.0/24"
}

module "storage" {
  source       = "../modules/storage"
}
