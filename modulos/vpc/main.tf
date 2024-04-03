# se define una VPC
resource "aws_vpc" "vpc_devops_prueba" {
  cidr_block = var.vpc_cidr_block
  tags       = {}
}
# se declara una subnet pública
resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc_devops_prueba.id
  cidr_block              = var.vpc_subnets[0]
  map_public_ip_on_launch = true
  tags = {
  }
}
# se declara una subnet privada
resource "aws_subnet" "subnet_private" {
  vpc_id     = aws_vpc.vpc_devops_prueba.id
  cidr_block = var.vpc_subnets[1]
  tags = {
  }
  depends_on = [
    aws_subnet.subnet_public
  ]
}
# Se crea una gateway de internet
resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.vpc_devops_prueba.id

  tags = {
  }
}
# Se crea una tabla de ruteo
resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.vpc_devops_prueba.id
  route {
    cidr_block = var.vpc_route_table_cidr_block
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }
  tags = {
  }
}
# Asocia la tabla de ruteo con la subnet pública
resource "aws_route_table_association" "vpc_crta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.vpc_route_table.id
}
# se crea grupo de seguridad
resource "aws_security_group" "vpc_security_group" {
  name        = var.vpc_sg_name_instance
  description = "grupo de seguridad para la instancia de devops prueba"
  vpc_id      = aws_vpc.vpc_devops_prueba.id
  # Regla para permitir el tráfico entrante a la lista de los puertos (SSH Y HTTP)
  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.ingress_protocol
      cidr_blocks = [var.sg_ingress_cidr_blocks]
    }
  }
  # Regla para permitir el tráfico saliente a todas partes
  egress {
    from_port        = var.egress_port
    to_port          = var.egress_port
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
  }
}
