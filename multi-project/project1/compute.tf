resource "google_compute_instance" "test-compute" {
  project      = "${module.project-factory.project_id}"
  name         = "bastion"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "subnet-central1"
    subnetwork_project = "${module.project-factory.project_id}"

    access_config {
      // Ephemeral IP
    }

  }

  depends_on = ["module.vpc-network"]
}

resource "google_compute_instance" "test-compute-east" {
  project      = "${module.project-factory.project_id}"
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "subnet-east1"
    subnetwork_project = "${module.project-factory.project_id}"
  }

  depends_on = ["module.vpc-network"]
}



