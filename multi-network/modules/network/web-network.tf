
module "vpc-web" {
  source       = "github.com/terraform-google-modules/terraform-google-network"
  network_name = "web"
  project_id   = "${var.project_id}"
  # shared_vpc_host = "true" 

  subnets = [
    {
      subnet_name           = "web-sec"
      subnet_ip             = "10.20.10.0/24"
      subnet_region         = "us-west1"
    },
    {
      subnet_name           = "web-int"
      subnet_ip             = "10.20.20.0/24"
      subnet_region         = "us-central1"
    },
    {
      subnet_name           = "web-ext"
      subnet_ip             = "10.20.30.0/24"
      subnet_region         = "us-east1"
    },
  ]

  secondary_ranges = {
    web-sec = [
      {
        range_name    = "sec-secondary"
        ip_cidr_range = "192.168.1.0/24"
      },
    ],
    web-int = [],
    web-ext = [],
  }

}
