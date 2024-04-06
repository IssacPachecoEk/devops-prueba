# retorna el id de la subred publica
output "output_subnet_public" {
  description = "retorna la subred publica creada"
  value = aws_subnet.subnet_public.id
  # value = [
  #   for subnet in aws_subnet.subnet_public : subnet.id
  # ]
}
# retorna el id de la subred privada
output "output_subnet_private" {
  description = "retorna la subred privada creada"
  value = aws_subnet.subnet_private.id
  # value = [
  #   for subnet in aws_subnet.subnet_public : subnet.id
  # ]
}
# retorna el id del grupo de seguridad
output "output_security_group" {
  description = "retorna el grupo de seguridad"
  value       = aws_security_group.vpc_security_group.id
}
# retorna el id del grupo de seguridad
output "output_aws_vpc_id" {
  description = "retorna el grupo de seguridad"
  value       = aws_vpc.main.id
}

output "output_local_az" {
  description = "retorna el grupo de seguridad"
  value       = local.az_names
}