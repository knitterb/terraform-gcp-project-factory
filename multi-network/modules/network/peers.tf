resource "google_compute_network_peering" "app-to-web-peering" {
  name = "app-to-web"
  network = "${module.vpc-app.network_self_link}"
  peer_network = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${module.vpc-web.network_name}"
}
resource "google_compute_network_peering" "web-to-app-peering" {
  name = "web-to-app"
  network = "${module.vpc-web.network_self_link}"
  peer_network = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${module.vpc-app.network_name}"
}
