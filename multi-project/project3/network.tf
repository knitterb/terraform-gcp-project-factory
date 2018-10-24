module "vpc-network" {
  source       = "github.com/terraform-google-modules/terraform-google-network"
  network_name = "shared-network-vpc"
  project_id   = "${module.project-factory.project_id}"
  shared_vpc_host = "true"

  subnets = [
    {
      subnet_name           = "shared-subnet-west1"
      subnet_ip             = "10.30.10.0/24"
      subnet_region         = "us-west1"
    },
    {
      subnet_name           = "shared-subnet-central1"
      subnet_ip             = "10.30.20.0/24"
      subnet_region         = "us-central1"
    },
    {
      subnet_name           = "shared-subnet-east1"
      subnet_ip             = "10.30.30.0/24"
      subnet_region         = "us-east1"
    },
  ]

  secondary_ranges = {
    shared-subnet-west1 = [
      {
        range_name    = "subnet-west1-secondary-01"
        ip_cidr_range = "192.168.62.0/24"
      },
    ],
    shared-subnet-central1 = [],
    shared-subnet-east1 = [],
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


