# recurso para la DNS y su asociación con el ALB y el certificado
resource "aws_route53_record" "route_web_devops" {
  allow_overwrite = true # checar
  zone_id = data.aws_route53_zone.route_web_devops.zone_id
  name    = var.nombre_dominio_route
  type    = var.tipo_registro
  ttl     = var.ttl
  records = ["${aws_acm_certificate.example.domain_validation_options.0.resource_record_name}"] # checar
}