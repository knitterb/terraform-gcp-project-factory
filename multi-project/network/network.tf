
locals {
  credentials_file_path = "${var.credentials_path}"
}

/******************************************
  Provider configuration
 *****************************************/
provider "google" {
  credentials = "${file(local.credentials_file_path)}"
}

resource "google_compute_network_peering" "peering1" {
  name = "peering-1to2"
  network = "${var.project_one_network_self_link}"
  peer_network = "https://www.googleapis.com/compute/v1/projects/${var.project_two_project_id}/global/networks/${var.project_two_vpc}"
}
resource "google_compute_network_peering" "peering2" {
  name = "peering-2to1"
  network = "${var.project_two_network_self_link}"
  peer_network = "https://www.googleapis.com/compute/v1/projects/${var.project_one_project_id}/global/networks/${var.project_one_vpc}"
}

resource "google_compute_shared_vpc_service_project" "shared-vpc-network-link" {
  host_project    = "${var.project_three_project_id}"
  service_project = "${var.project_two_project_id}"
}

