output "s3_artifact_arn" {
  value       = aws_s3_bucket.s3_codepipeline_artifacts.arn
  description = "retorna el bucket creado para los artefactos"
}
output "s3_artifact_id" {
  value       = aws_s3_bucket.s3_codepipeline_artifacts.id
  description = "retorna el id del bucket creado para los artefactos"
}