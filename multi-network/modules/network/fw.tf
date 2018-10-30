resource "google_compute_firewall" "tr-allow-ssh" {
  name    = "tr-allow-ssh"
  network = "${module.vpc-tr.network_name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]
}

resource "google_compute_firewall" "web-allow-ssh" {
  name    = "web-allow-ssh"
  network = "${module.vpc-web.network_name}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]
}

