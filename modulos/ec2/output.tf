output "api_base_url" {
  value = "https://${aws_instance.example.private_dns}:8433/"
}