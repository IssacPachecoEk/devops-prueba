resource "aws_acm_certificate" "acm_web_devops" {
  domain_name       = var.nombre_dominio_certificado
  validation_method = var.metodo_validacion
}

resource "aws_acm_certificate_validation" "example" {
  certificate_arn   = aws_acm_certificate.acm_web_devops.arn
}