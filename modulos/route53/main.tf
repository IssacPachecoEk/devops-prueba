# Recurso para la DNS y su asociación con el ALB y el certificado
resource "aws_route53_record" "example" {
  zone_id = "your_zone_id"  # Reemplaza con tu ID de zona en Route 53
  name    = "example.com"   # Reemplaza con tu dominio

  type    = "A"
  ttl     = "300"

  alias {
    name                   = aws_lb.example.dns_name # consultar alb
    zone_id                = aws_lb.example.zone_id # consultar alb
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "example_cert_validation" {
  zone_id = "your_zone_id"  # Reemplaza con tu ID de zona en Route 53
  name    = "_acme-challenge.example.com"  # Reemplaza con tu dominio

  type    = "CNAME"
  ttl     = "300"

  records = ["${aws_acm_certificate.example.domain_validation_options.0.resource_record_name}"]
}