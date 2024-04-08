# crea el s3 para subir el achivo terraform.ftstate
resource "aws_s3_bucket" "s3_codepipeline_artifacts" {
  bucket = var.s3_artifact_name
  tags   = var.common_tag
}