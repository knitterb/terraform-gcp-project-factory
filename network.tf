module "vpc-network" {
  source       = "github.com/terraform-google-modules/terraform-google-network"
  network_name = "my-network-vpc"
  project_id   = "${module.project-factory.project_id}"

  subnets = [
    {
      subnet_name           = "subnet-01"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-west1"
    },
    {
      subnet_name           = "subnet-02"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-central1"
    },
  ]

  secondary_ranges = {
    subnet-01 = [
      {
        range_name    = "subnet-01-secondary-02"
        ip_cidr_range = "192.168.64.0/24"
      },
    ],
    subnet-02 = [
      {
        range_name    = "subnet-02-secondary-01"
        ip_cidr_range = "192.168.65.0/24"
      },
    ],
  }

}