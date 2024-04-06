output "output_certificate" {
  description = "retorna el certificado creado"
  value       = aws_acm_certificate.main.arn
}