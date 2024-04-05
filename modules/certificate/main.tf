resource "aws_acm_certificate" "main" {
  domain_name       = var.name_domain_certificado
  validation_method = var.validation_method
  validation_option {
    domain_name       = "${var.subdomain_domain_certificate}.${var.name_domain_certificate}"
    validation_domain = var.name_domain_certificado
  }
  tags = var.common_tag
}