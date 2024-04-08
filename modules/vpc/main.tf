# principal recurso
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-devops"
    tags_all = jsonencode(var.common_tag)
  }
}
# se declara una subred pública
resource "aws_subnet" "subnet_public" {
  #for_each                = { for indice, valor_az_name in local.az_names : indice => valor_az_name }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_subnet_public #"10.10.${each.key}.0/24"
  # availability_zone       = "us-east-1a" #local.az_names[each.key]
  map_public_ip_on_launch = var.vpc_map_public_ip_on_launch
 tags = {
    Name = "subnet-publica" #"subnet-${each.key + 1}"
    tags_all = jsonencode(var.common_tag)
  }
}
# se declara una subred privada
resource "aws_subnet" "subnet_private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_subnet_private
 tags = {
    Name = "subnet-privada"
    tags_all = jsonencode(var.common_tag)
  }
}
# Se crea una gateway de internet
resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "ig-devops"
    tags_all = jsonencode(var.common_tag)
  }
}

# Se crea una tabla de ruteo
resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0" #var.vpc_route_table_cidr_block
    # nat_gateway_id = aws_nat_gateway.nat_gateway.id
    #instance_id = aws_instance.main.id
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }
  tags = {
    Name = "rt-devops"
    tags_all = jsonencode(var.common_tag)
  }
}
# Asocia la tabla de ruteo con la subnet privada
resource "aws_route_table_association" "private_association" {
  for_each       = {
    "public_subnet"  = aws_subnet.subnet_public.id,
    "private_subnet" = aws_subnet.subnet_private.id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.vpc_route_table.id
}
# puerta de enlace para la subred privada accedan a internet
resource "aws_nat_gateway" "nat_subnet_private" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.subnet_private.id
}

# se crea grupo de seguridad
resource "aws_security_group" "vpc_security_group" {
  name        = var.vpc_sg_name_instance
  description = "grupo de seguridad para la instancia de devops prueba"
  vpc_id      = aws_vpc.main.id
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
    from_port   = var.egress_port
    to_port     = var.egress_port
    protocol    = var.egress_protocol
    cidr_blocks = [var.sg_egress_cidr_blocks]
  }
  tags = {
    Name = "sg-devops"
    tags_all = jsonencode(var.common_tag)
  }
}
