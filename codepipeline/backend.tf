# crea el s3 para subir el achivo terraform.ftstate
resource "aws_s3_bucket" "backend_bucket" {
  bucket = "codepipeline-devops-terraform-issac"
}