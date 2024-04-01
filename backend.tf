# Bucket S3 para almacenar el código de la aplicación.
#preguntar si se sube el codigo de la pagina perse o de infra(terraform.tfstate)
module "bucket_backend" {
  source      = "./modulos/s3"
  providers = {
  aws = var.tags_general.alias["virginia"]
  }
}

# falta el modulo de aim para el rol para subir el archivo terraform.tfstate al bucket

terraform {
  required_version = "=>1.7.5"
  backend "remote" {
    region         = var.tags_general.region
    bucket         = module.bucket_backend.bucket_arn
    key            = "terraform.tfstate"
    profile        = var.profile_backend
    role_arn       = var.role_arn_backend
    encrypt        = "true"
  }
}