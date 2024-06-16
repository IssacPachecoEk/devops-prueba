terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.43.0"
    }
  }
  required_version = "~>1.7.5"
}
provider "aws" {
  region = local.region["virginia"]
  alias  = "virginia"
  default_tags {
    tags = local.common_tag
  }
}
module "vpc" {
  source                     = "../vpc"
  vpc_cidr_block             = "10.10.0.0/16"
  vpc_subnet_public          = "10.10.1.0/24"
  vpc_subnet_private         = "10.10.2.0/24"
  vpc_route_table_cidr_block = "0.0.0.0/0"
  vpc_sg_name_instance       = "grupo-seguridad-devops"
  ingress_ports_list         = [80, 22, 5432]
  ingress_protocol           = "tcp"
  sg_ingress_cidr_blocks     = "0.0.0.0/0"
  egress_port                = 0
  egress_protocol            = "-1"
  sg_egress_cidr_blocks      = "0.0.0.0/0"

  common_tag                 = var.common_tag
}
module "ec2" {
  source            = "./modules/ec2"
  ami_ec2           = "ami-0aa7d40eeae50c9a9"
  instance_type_ec2 = "t2.micro"
  key_pair_ec2      = "key-pair-issac"
  common_tag        = local.common_tag
}
# module "dns" {
#   source         = "./modules/dns"
#   ttl_time       = 300
#   record_type    = "A"
#   domain_name    = "devopspruebaexamen.com"
#   subdomain_name = "subdominio"
#   common_tag     = local.common_tag
# }
module "rds" {
  source                = "./modules/rds"
  identifier_rds        = "devops"
  db_name_rds           = "mypostgres"
  allocated_storage_rds = 10
  engine_rds            = "postgres"
  engine_version_rds    = "14"
  instance_class_rds    = "db.m5d.large"
  username_rds          = "foo"
  password_rds          = "foobarbaz"
  common_tag            = local.common_tag
}
module "s3" {
  source                         = "./modules/s3"
  bucket_name                    = "devops-bucket-test-2024"
  path_object                    = "modules"
  source_object                  = "**/*.*"
  content_type_object            = "text/plain"
  common_tag                     = local.common_tag
  bucket_versioning_enabled      = "Disabled"
  bucket_block_public_acls       = false
  bucket_block_public_policy     = false
  bucket_ignore_public_acls      = false
  bucket_restrict_public_buckets = false
  bucket_object_ownership        = "BucketOwnerPreferred"
}

