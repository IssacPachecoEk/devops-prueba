# esta salida retorna el arn generado del bucket creado
output "output_bucket_arn" {
  value = aws_s3_bucket.bucket_name.arn
}
# esta salida retorna el id del bucket creado
output "output_bucket_id" {
  description = "El ID del bucket"
  value       = aws_s3_bucket.bucket_name.id
}