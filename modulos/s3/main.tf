# modulo de iam para la politica del bucket
module "bucket_iam" {
  source      = "./modulos/iam"
  providers = {
    aws = var.tags_general.alias["virginia"]
  }
}
# se define el recurso del servico s3 para almacenar el archivo terraform.tfstate
resource "aws_s3_bucket" "bucket_backend" {
  bucket = "${var.bucket_name}-${local.s3_sufijo}"
  tags = {
    Name = "devops-prueba-${local.tag_recurso_sufijo}"
    fecha_creado = timestamp(var.tags_general.fecha)
    version = var.tags_general.version
  }
}
# se declara el versionamiento de los objetos del bucket para terraform.tfstate
resource "aws_s3_bucket_versioning" "bucket_backend" {
  bucket = aws_s3_bucket.bucket_backend.id
  versioning_configuration {
    status = "Enabled"
  }
}
# declaro el acceso publico al bucket como bloqueado
resource "aws_s3_bucket_public_access_block" "bucket_backend" {
  bucket = aws_s3_bucket.bucket_backend.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
# declaro el control de la propiedad del bucket
resource "aws_s3_bucket_ownership_controls" "bucket_backend" {
  bucket = aws_s3_bucket.bucket_backend.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
# declaro los permisos del acceso al bucket como privados
resource "aws_s3_bucket_acl" "bucket_backend" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_backend,
    aws_s3_bucket_public_access_block.bucket_backend
  ]
  bucket = aws_s3_bucket.bucket_backend.id
  acl    = "private"
}
# 
resource "aws_s3_bucket_policy" "bucket_backend" {
  bucket = aws_s3_bucket.bucket_backend.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}