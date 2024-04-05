output "output_certificate_hijo" {
  value = module.acm.output_certificate
}
output "output_dns_name" {
  value = [for bd in aws_lb.main : bd.dns_name]
}
output "output_zone_id" {
  value = [for bd in aws_lb.main : bd.zone_id]
}
