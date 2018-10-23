module "vpc-network" {
  source       = "github.com/terraform-google-modules/terraform-google-network"
  network_name = "my-network-vpc"
  project_id   = "${module.project-factory.project_id}"

  subnets = [
    {
      subnet_name           = "subnet-west1"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-west1"
    },
    {
      subnet_name           = "subnet-central1"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-central1"
    },
    {
      subnet_name           = "subnet-east1"
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = "us-east1"
    },
  ]

  secondary_ranges = {
    subnet-west1 = [
      {
        range_name    = "subnet-west1-secondary-01"
        ip_cidr_range = "192.168.60.0/24"
      },
    ],
    subnet-central1 = [],
    subnet-east1 = [],
  }

}

resource "google_compute_firewall" "fw-ssh-allow" {
  name = "allow-ssh"
  network = "${module.vpc-network.network_self_link}"
  project   = "${module.project-factory.project_id}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network_peering" "peering1" {
  name = "peering-1to2"
  network = "${module.vpc-network.network_self_link}"
  peer_network = "https://www.googleapis.com/compute/v1/projects/knitter-build-project2/global/networks/my-network-vpc"
}




