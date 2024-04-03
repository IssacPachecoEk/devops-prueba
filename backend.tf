# Bucket S3 para almacenar el código de la aplicación.
#preguntar si se sube el codigo de la pagina perse o de infra(terraform.tfstate)
# module "bucket_backend" {
#   source = "./modulos/s3"
#   # version      = "1.0.0" #local.version
#   backend_name = "andrei-test-lol" #local.bucket_name_sufijo
#   tags         = local.common_tag
# }

# falta el modulo de aim para el rol para subir el archivo terraform.tfstate al bucket

terraform {
  required_version = "~>1.7.5"
  backend "s3" {
    region = "us-east-2"       #local.region["virginia"]
    bucket = "andrei-test-lol" #module.bucket_backend.output_bucket_arn
    key    = "terraform.tfstate"
    # profile  = var.profile_backend  # checar
    # role_arn = var.role_arn_backend # checar
    # encrypt  = "true"
  }
}
