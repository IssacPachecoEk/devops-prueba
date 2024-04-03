terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.43.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = "=>1.7.5"
}
provider "aws" {
  region = local.region["virginia"] 
  # no recomienda poner las llaves de la cuenta del usuario, sino por variables de entorno del sistema
  access_key = var.access_key
  # lo puse aqui solo por temas de desmostración
  secret_key = var.secret_key
  # aqui otra forma de usar las credenciales, pasandole el path de las credenciales
  shared_credentials_file = file("${var.location_credentials_file}")
  profile    = var.profile_aws
  alias      = local.alias["virginia"]
  default_tags {
    tags = local.common_tag
  }
}