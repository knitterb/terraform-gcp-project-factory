resource "google_compute_instance" "test-compute" {
  project      = "${module.project-factory.project_id}"
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${module.vpc-network.subnet_names[1]}"
    subnetwork_project = "${module.project-factory.project_id}"
  }
}