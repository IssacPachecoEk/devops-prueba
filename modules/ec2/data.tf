# se necesita crear manualmente la llave e importarlo
data "aws_key_pair" "existing_key_pair" {
  key_name = var.key_pair_ec2
}
