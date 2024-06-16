# module "vpc" {
#   source                     = "../vpc"
#   vpc_cidr_block             = "10.10.0.0/16"
#   vpc_subnet_public          = "10.10.1.0/24"
#   vpc_subnet_private         = "10.10.2.0/24"
#   vpc_route_table_cidr_block = "0.0.0.0/0"
#   vpc_sg_name_instance       = "grupo-seguridad-devops"
#   ingress_ports_list         = [80, 22, 5432]
#   ingress_protocol           = "tcp"
#   sg_ingress_cidr_blocks     = "0.0.0.0/0"
#   egress_port                = 0
#   egress_protocol            = "-1"
#   sg_egress_cidr_blocks      = "0.0.0.0/0"

#   common_tag                 = var.common_tag
# }
# principal recurso
resource "aws_instance" "main" {
  #for_each               = { for indice, valor_subnet_id in module.vpc.output_subnet_public : indice => valor_subnet_id }
  ami                    = var.ami_ec2
  instance_type          = var.instance_type_ec2
  subnet_id              = module.vpc.output_subnet_public #each.value
  vpc_security_group_ids = [module.vpc.output_security_group] 
  key_name               = data.aws_key_pair.existing_key_pair.key_name
  user_data              = <<-EOF
                    #!/bin/bash
                    yum update -y
                    yum install httpd -y
                    systemctl enable httpd
                    systemctl start httpd
                    echo "Este es un mensaje" > ~/index.html
                  EOF            
  depends_on             = [module.vpc.subnet_public, module.vpc.vpc_security_group]
  tags = {
    Name     = "instancia-devops" #"instance-${each.key + 1}"
    tags_all = jsonencode(var.common_tag)
  }
}