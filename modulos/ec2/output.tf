output "ec2_url" {
  value = "https://${aws_instance.instancia_ec2_web_devops.public_dns}:80/"
}
