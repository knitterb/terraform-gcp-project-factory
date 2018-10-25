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
    subnet-west1 = [],
    subnet-central1 = [],
    subnet-east1 = [],
  }

}
