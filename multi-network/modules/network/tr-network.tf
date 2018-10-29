

module "tr-app" {
  source       = "github.com/terraform-google-modules/terraform-google-network"
  network_name = "tr"
  project_id   = "${var.project_id}"
  # shared_vpc_host = "true" 

  subnets = []

  secondary_ranges = {}

}
