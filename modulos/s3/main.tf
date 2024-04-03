# modulo de iam para la politica del bucket
# module "bucket_iam" {
#   source = "../modulos/iam"
#   # version = local.version
#   # tags        = ""
# }
# se define el nombre del s3 para almacenar el archivo terraform.tfstate
resource "aws_s3_bucket" "bucket_name" {
  bucket = var.bucket_name
  # tags   = var.tags_bucket
}
# se declara el versionamiento de los objetos del bucket para terraform.tfstate
resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket_name.id
  versioning_configuration {
    status = var.bucket_versioning_enabled
  }
}
# declaro el acceso publico al bucket como bloqueado
resource "aws_s3_bucket_public_access_block" "bucket_public_access_block" {
  bucket                  = aws_s3_bucket.bucket_name.id
  block_public_acls       = var.bucket_block_public_acls
  block_public_policy     = var.bucket_block_public_policy
  ignore_public_acls      = var.bucket_ignore_public_acls
  restrict_public_buckets = var.bucket_restrict_public_buckets
}
# declaro el control de la propiedad del bucket
resource "aws_s3_bucket_ownership_controls" "bucket_ownership_controls" {
  bucket = aws_s3_bucket.bucket_name.id
  rule {
    object_ownership = var.bucket_object_ownership
  }
}
# declaro los permisos del acceso al bucket como privados
resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership_controls,
    aws_s3_bucket_public_access_block.bucket_public_access_block
  ]
  bucket = aws_s3_bucket.bucket_name.id
  acl    = var.bucket_acl
}
# 
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket_name.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}
