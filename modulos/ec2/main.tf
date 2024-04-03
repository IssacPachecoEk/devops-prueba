module "vpc" {
  source                     = "../vpc"
  vpc_cidr_block             = "10.10.0.0/16"
  vpc_sg_name_instance       = "instancia-devops-prueba"
  vpc_subnets                = ["10.10.1.0/24", "10.10.2.0/24"]
  vpc_route_table_cidr_block = "0.0.0.0/0"
  ingress_ports_list         = [80, 22]
  ingress_protocol           = false
  sg_ingress_cidr_blocks     = "0.0.0.0/0"
  egress_port                = 0
  egress_protocol            = "-1"
  sg_egress_cidr_blocks      = "0.0.0.0/0"

  # version = local.version
}

resource "aws_instance" "instancia_ec2_web_devops" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = [module.vpc.vpc_public_subnets.id]     # tomar de la vpc
  vpc_security_group_ids = [module.vpc.out_vpc_security_group.id] # tomar de la vpc
  # key_name               = data.aws_key_pair.key_ec2
  # user_data = file("userdata-ec2.sh")

  # declaro una condicional para saber si le asigno todas las zonas de dispobilidad de la region o en especifico algunas
  # availability_zone ? : var.todas_zonas_disponibles = true ? local.mapeo_zonas_todas : var.mapeo_zonas_especificas

  # lifecycle {
  #   precondition {
  #     condition     = data.aws_ami.example.architecture == "x86_64"
  #     error_message = "The selected AMI must be for the x86_64 architecture."
  #   }
  #   postcondition {
  #     condition     = self.public_dns != ""
  #     error_message = "EC2 instance must be in a VPC that has public DNS hostnames enabled."
  #   }
  # }

  # tags = {
  #   tags = local.common_tag
  # }
}
