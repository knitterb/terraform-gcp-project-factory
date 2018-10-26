
terraform {
  backend "gcs" {
    credentials="credentials.json"
    prefix = "multi-project"
  }
}

module "network" {
  source = "./modules/network"
  project_id = "${var.project_id}"
}

