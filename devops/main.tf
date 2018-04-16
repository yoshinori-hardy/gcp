//resource "google_project" "gcpdop" {
//  name = "gcpdop"
//  project_id = "gcpdop"
//}

module "Core_Network" {
  source         = "../modules/network"
  source_image   = "centos-6-v20180314"
  name           = [
                   "jenkins",
                   "vault",
                   "ansible"
                   ]
  machine_type   = "g1-small"
  region         = "europe-west2"
  subnet_dmz     = "10.1.1.0/24"
  subnets        = [
                   "10.1.2.0/24",
                   "10.1.3.0/24",
                   "10.1.4.0/24"
                   ]
  nat-int-ip       = "10.1.1.10"
  can_ip_forward   = "true"
  local_cmd_create = "sleep 30"
}

module "storage" {
  source         = "../modules/storage"
}

module "Provision_Jenkins" {
  name           = "jenkins"
  source         = "../modules/http-app"
  source_image   = "centos7-base-1523629144"
  disk_size_gb   = "20"
  target_size    = "1"
  listener_port  = "80"
  machine_type   = "g1-small"
  region         = "europe-west2"
  app-subnets    = "${module.Core_Network.app-subnets}"
  sub-map        = "${module.Core_Network.sub-map}"
  health-check   = "/hello_world.html"
}

module "Provision_Vault" {
  name           = "vault"
  source         = "../modules/http-app"
  source_image   = "centos7-base-1523629144"
  disk_size_gb   = "20"
  target_size    = "1"
  listener_port  = "80"
  machine_type   = "g1-small"
  region         = "europe-west2"
  app-subnets    = "${module.Core_Network.app-subnets}"
  sub-map        = "${module.Core_Network.sub-map}"
  health-check   = "/hello_world.html"
}

module "Provision_Ansible" {
  name           = "ansible"
  source         = "../modules/http-app"
  source_image   = "centos7-base-1523629144"
  disk_size_gb   = "20"
  target_size    = "1"
  listener_port  = "80"
  machine_type   = "g1-small"
  region         = "europe-west2"
  app-subnets    = "${module.Core_Network.app-subnets}"
  sub-map        = "${module.Core_Network.sub-map}"
  health-check   = "/hello_world.html"
}
