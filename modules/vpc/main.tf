# principal recurso
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "vpc-devops"
    tags_all = jsonencode(var.common_tag)
  }
}

# se declara una subred pública
resource "aws_subnet" "subnet_public" {
  for_each                = { for indice, valor_az_name in local.az_names : indice => valor_az_name }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.10.${each.key}.0/24"
  availability_zone       = local.az_names[each.key]
  map_public_ip_on_launch = var.vpc_map_public_ip_on_launch
 tags = {
    Name = "subnet-${each.key + 1}"
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
    cidr_block = var.vpc_route_table_cidr_block
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }
  tags = {
    Name = "rt-devops"
    tags_all = jsonencode(var.common_tag)
  }
}
# Asocia la tabla de ruteo con la subnet pública
resource "aws_route_table_association" "vpc_crta_subnet_public" {
  count          = length(aws_subnet.subnet_public)
  subnet_id      = aws_subnet.subnet_public[count.index].id
  route_table_id = aws_route_table.vpc_route_table.id
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