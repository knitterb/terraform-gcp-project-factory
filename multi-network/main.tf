
terraform {
  backend "gcs" {
    credentials="credentials.json"
    prefix = "multi-project"
  }
}

provider "google" {
  project     = "${var.project_id}"
  region      = "us-central1"
}

module "network" {
  source = "./modules/network"
  project_id = "${var.project_id}"
}

module "compute-tr" {
  source = "./modules/compute"
  network_self_link = "${module.network.tr_network_self_link}"
  subnetwork = "tr-tr"
}

module "compute-web" {
  source = "./modules/compute"
  network_self_link = "${module.network.web_network_self_link}"
  subnetwork = "web-sec"
}

