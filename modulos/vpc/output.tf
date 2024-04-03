output "vpc_public_subnets" {
  description = "retorna la subnet publica creada"
  value       = aws_subnet.subnet_public.id
}

output "out_vpc_security_group" {
  description = "retorna el grupo de seguridad"
  value       = aws_security_group.vpc_security_group.id
}

