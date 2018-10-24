terraform {
  backend "gcs" {
    credentials="credentials.json"
    prefix = "multi-project"
  }
}
module "project_one" {
  source = "./project1/"

  credentials_path = "${var.credentials_path}"
  repository = "${var.repository}"
  organization_id = "${var.organization_id}"
  billing_account = "${var.billing_account}"
  project_prefix = "${var.project_prefix}"
}

module "project_two" {
  source = "./project2/"

  credentials_path = "${var.credentials_path}"
  repository = "${var.repository}"
  organization_id = "${var.organization_id}"
  billing_account = "${var.billing_account}"
  project_prefix = "${var.project_prefix}"

  shared_network_self_link = "${module.project_three.network_vpc}"
  shared_network_project_id = "${module.project_three.project_id}"
}

module "project_three" {
  source = "./project3/"

  credentials_path = "${var.credentials_path}"
  repository = "${var.repository}"
  organization_id = "${var.organization_id}"
  billing_account = "${var.billing_account}"
  project_prefix = "${var.project_prefix}"
}

module "network" {
  source = "./network/"

  credentials_path = "${var.credentials_path}"
  project_one_network_self_link = "${module.project_one.network_self_link}"
  project_two_network_self_link = "${module.project_two.network_self_link}"
  project_one_project_id = "${module.project_one.project_id}"
  project_two_project_id = "${module.project_two.project_id}"
  project_three_project_id = "${module.project_three.project_id}"
  project_one_vpc = "${module.project_one.network_vpc}"
  project_two_vpc = "${module.project_two.network_vpc}"
}

