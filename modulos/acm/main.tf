resource "aws_acm_certificate" "acm_web_devops" {
  domain_name       = var.name_domain_certificado
  validation_method = var.validation_method
}

resource "aws_acm_certificate_validation" "acm_validation_web_devops" {
  certificate_arn = aws_acm_certificate.acm_web_devops.arn
}
