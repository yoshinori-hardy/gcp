// build the base network and nat service 
module "base_network" {
  source = "../modules/network"
  source_image = "centos-6-v20180314"
  machine_type = "g1-small"
  region       = "europe-west2"
}
