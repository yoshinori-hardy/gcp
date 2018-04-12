//resource "google_project" "gcpdop" {
//  name = "gcpdop"
//  project_id = "gcpdop"
//}

module "Core_Network" {
  source         = "../modules/network"
  source_image   = "centos-6-v20180314"
  machine_type   = "g1-small"
  region         = "europe-west2"
  subnet_dmz     = "10.1.1.0/24"
  subnets        = [
                   "10.1.2.0/24",
                   "10.1.3.0/24",
                   "10.1.4.0/24"
                   ]
}

module "storage" {
  source         = "../modules/storage"
}

module "Provision_Jenkins" {
  source         = "../modules/jenkins"
  source_image   = "centos-6-v20180314"
  target_size    = "3"
  jenkins_port   = "80"
  machine_type   = "g1-small"
  region         = "europe-west2"
  app-subnets    = "${module.Core_Network.app-subnets}"
}
