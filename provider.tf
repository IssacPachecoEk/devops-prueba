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
  region = var.tags_general.region["virginia"] 
  access_key = var.access_key
  secret_key = var.secret_key
  alias      = var.tags_general.alias["virginia"]
  default_tags {
    tags_general = var.tags_general
  }

}