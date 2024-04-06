# crea el s3 para subir el achivo terraform.ftstate
resource "aws_s3_bucket" "s3_codepipeline_artifacts" {
  bucket = "codepipeline-artifacts-devops-terraform-issac-version-nueva"
}
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.s3_codepipeline_artifacts.id
  versioning_configuration {
    status = "Disabled"
  }
}