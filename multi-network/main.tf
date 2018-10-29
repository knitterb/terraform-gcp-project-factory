
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

