

module "vpc-app" {
  source       = "github.com/terraform-google-modules/terraform-google-network"
  network_name = "vpc-app"
  project_id   = "${var.project_id}"
  # shared_vpc_host = "true" 

  subnets = [
    {
      subnet_name           = "app-sec"
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = "us-central1"
    },
    {
      subnet_name           = "app-c"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-central1"
    },
    {
      subnet_name           = "app-s"
      subnet_ip             = "10.10.30.0/24"
      subnet_region         = "us-central1"
    },
    {
      subnet_name           = "app-b"
      subnet_ip             = "10.10.40.0/24"
      subnet_region         = "us-central1"
    },
  ]

  secondary_ranges = {
    app-sec = [
      {
        range_name    = "sec-secondary"
        ip_cidr_range = "192.168.0.0/24"
      },
    ],
    app-c = [],
    app-s = [],
    app-b = [],
  }

}
