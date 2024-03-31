resource "aws_acm_certificate" "example" {
  domain_name       = "example.com"  # Reemplaza con tu dominio
  validation_method = "EMAIL"
}