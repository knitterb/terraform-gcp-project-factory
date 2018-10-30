output "web_network_self_link" {
  value = "${module.vpc-web.network_self_link}"
}
output "app_network_self_link" {
  value = "${module.vpc-app.network_self_link}"
}
output "tr_network_self_link" {
  value = "${module.vpc-tr.network_self_link}"
}