resource "google_compute_instance" "test" {
  name         = "test-${var.subnetwork}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # network = "${var.network_self_link}"
    subnetwork = "${var.subnetwork}"

    access_config {
      // Ephemeral IP
    }
  }
}
