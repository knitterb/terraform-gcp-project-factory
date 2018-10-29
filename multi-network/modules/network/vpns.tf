
# vpn tr -> web
resource "google_compute_address" "tr-to-web-vpn-ip" {
  name = "tr-to-web-vpn-ip"
}
resource "google_compute_vpn_gateway" "tr-to-web-vpn-gateway" {
  name = "tr-to-web-vpn-gateway"
  network    = "${module.vpc-tr.network_name}"
}
resource "google_compute_forwarding_rule" "fr-tr-to-web-vpn_esp" {
  name        = "fr-tr-to-web-vpn-esp"
  ip_protocol = "ESP"
  ip_address  = "${google_compute_address.tr-to-web-vpn-ip.address}"
  target      = "${google_compute_vpn_gateway.tr-to-web-vpn-gateway.self_link}"
}
resource "google_compute_forwarding_rule" "fr-tr-to-web-vpn_udp500" {
  name        = "fr-tr-to-web-vpn-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${google_compute_address.tr-to-web-vpn-ip.address}"
  target      = "${google_compute_vpn_gateway.tr-to-web-vpn-gateway.self_link}"
}

resource "google_compute_forwarding_rule" "fr-tr-to-web-vpn_udp4500" {
  name        = "fr-tr-to-web-vpn-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${google_compute_address.tr-to-web-vpn-ip.address}"
  target      = "${google_compute_vpn_gateway.tr-to-web-vpn-gateway.self_link}"
}
resource "google_compute_vpn_tunnel" "tr-to-web-vpn_tunnel1" {
  name          = "tr-to-web-vpn-tunnel1"
  peer_ip       = "${google_compute_address.web-to-tr-vpn-ip.address}"
  shared_secret = "secret"

  target_vpn_gateway = "${google_compute_vpn_gateway.tr-to-web-vpn-gateway.self_link}"
  local_traffic_selector = [
    "172.16.0.0/24",
  ]

  depends_on = [
    "google_compute_forwarding_rule.fr-tr-to-web-vpn_esp",
    "google_compute_forwarding_rule.fr-tr-to-web-vpn_udp500",
    "google_compute_forwarding_rule.fr-tr-to-web-vpn_udp4500",
  ]
}
resource "google_compute_route" "tr-to-web-vpn-route1" {
  name       = "tr-to-web-vpn-route1"
  network    = "${module.vpc-tr.network_name}"
  dest_range = "172.16.0.0/24"
  priority   = 1000

  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.tr-to-web-vpn_tunnel1.self_link}"

  depends_on = [
    "google_compute_vpn_tunnel.tr-to-web-vpn_tunnel1"
  ]
}


# vpn tr -> web
resource "google_compute_address" "web-to-tr-vpn-ip" {
  name = "web-to-tr-vpn-ip"
}
resource "google_compute_vpn_gateway" "web-to-tr-vpn-gateway" {
  name = "web-to-tr-vpn-gateway"
  network    = "${module.vpc-web.network_name}"
}

resource "google_compute_forwarding_rule" "fr-web-to-tr-vpn_esp" {
  name        = "fr-web-to-tr-vpn-esp"
  ip_protocol = "ESP"
  ip_address  = "${google_compute_address.web-to-tr-vpn-ip.address}"
  target      = "${google_compute_vpn_gateway.web-to-tr-vpn-gateway.self_link}"
}
resource "google_compute_forwarding_rule" "fr-web-to-tr-vpn_udp500" {
  name        = "fr-web-to-tr-vpn-udp500"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = "${google_compute_address.web-to-tr-vpn-ip.address}"
  target      = "${google_compute_vpn_gateway.web-to-tr-vpn-gateway.self_link}"
}

resource "google_compute_forwarding_rule" "fr-web-to-tr-vpn_udp4500" {
  name        = "fr-web-to-tr-vpn-udp4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = "${google_compute_address.web-to-tr-vpn-ip.address}"
  target      = "${google_compute_vpn_gateway.web-to-tr-vpn-gateway.self_link}"
}
resource "google_compute_vpn_tunnel" "web-to-tr-vpn_tunnel1" {
  name          = "web-to-tr-vpn-tunnel1"
  peer_ip       = "${google_compute_address.tr-to-web-vpn-ip.address}"
  shared_secret = "secret"

  target_vpn_gateway = "${google_compute_vpn_gateway.web-to-tr-vpn-gateway.self_link}"
  local_traffic_selector = [
    "172.16.0.0/24",
  ]

  depends_on = [
    "google_compute_forwarding_rule.fr-web-to-tr-vpn_esp",
    "google_compute_forwarding_rule.fr-web-to-tr-vpn_udp500",
    "google_compute_forwarding_rule.fr-web-to-tr-vpn_udp4500",
  ]
}
resource "google_compute_route" "web-to-tr-vpn-route1" {
  name       = "web-to-tr-vpn-route1"
  network    = "${module.vpc-web.network_name}"
  dest_range = "172.16.0.0/24"
  priority   = 1000

  next_hop_vpn_tunnel = "${google_compute_vpn_tunnel.web-to-tr-vpn_tunnel1.self_link}"

  depends_on = [
    "google_compute_vpn_tunnel.web-to-tr-vpn_tunnel1"
  ]
}



