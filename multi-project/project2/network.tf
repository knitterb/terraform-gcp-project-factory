module "vpc-network" {
  source       = "github.com/terraform-google-modules/terraform-google-network"
  network_name = "my-network-vpc"
  project_id   = "${module.project-factory.project_id}"

  subnets = [
    {
      subnet_name           = "subnet-west1"
      subnet_ip             = "10.20.10.0/24"
      subnet_region         = "us-west1"
    },
    {
      subnet_name           = "subnet-central1"
      subnet_ip             = "10.20.20.0/24"
      subnet_region         = "us-central1"
    },
    {
      subnet_name           = "subnet-east1"
      subnet_ip             = "10.20.30.0/24"
      subnet_region         = "us-east1"
    },
  ]

  secondary_ranges = {
    subnet-west1 = [
      {
        range_name    = "subnet-west1-secondary-01"
        ip_cidr_range = "192.168.61.0/24"
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


resource "google_compute_shared_vpc_service_project" "shared_vpc_service" {
  host_project      = "${var.shared_network_project_id}"
  service_project   = "${module.project-factory.project_id}"
}


