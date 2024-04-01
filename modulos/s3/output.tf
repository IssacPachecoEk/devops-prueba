# esta salida retorna el arn generado del bucket
output "bucket_arn" {
  value = aws_s3_bucket.bucket_backend.arn
}