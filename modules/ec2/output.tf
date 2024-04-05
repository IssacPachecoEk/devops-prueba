output "output_aws_instance_id" {
  # value = aws_instance.main.id
  value = [
    for ec2 in aws_instance.main : ec2.id
  ]
}
output "output_instance_public_ip" {
  # value = aws_instance.main.public_ip
  value = [
    for ec2 in aws_instance.main : ec2.public_ip
  ]
}
output "output_ec2_public_dns" {
  value = [for ec2 in aws_instance.main : "https://${ec2.public_dns}:80/"]
}
output "output_subnet_public" {
  value = module.vpc.output_subnet_public
}
output "output_security_group" {
  value = module.vpc.output_security_group
}
output "output_aws_vpc_id" {
  description = "retorna el grupo de seguridad"
  value       = module.vpc.output_aws_vpc_id
}

