

module "vpc-tr" {
  source       = "github.com/terraform-google-modules/terraform-google-network"
  network_name = "vpc-tr"
  project_id   = "${var.project_id}"
  # shared_vpc_host = "true" 

  subnets = [
    {
      subnet_name           = "tr-tr"
      subnet_ip             = "10.30.10.0/24"
      subnet_region         = "us-central1"
    },

  ]

  secondary_ranges = {
    tr-tr = [
      {
        range_name    = "sec-secondary"
        ip_cidr_range = "192.168.0.0/24"
      },
    ],

  }

}
