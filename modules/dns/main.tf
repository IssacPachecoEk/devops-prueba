module "ec2" {
  source            = "../ec2"
  ami_ec2           = "ami-0aa7d40eeae50c9a9"
  instance_type_ec2 = "t2.micro"
  key_pair_ec2      = "key-pair-issac"
  common_tag        = var.common_tag
}
# crea la zona de la ruta
resource "aws_route53_zone" "route53_zone" {
  name = var.domain_name
  tags = var.common_tag
}
# recurso princiap para la DNS y su asociación con el ALB y el certificado
resource "aws_route53_record" "main" {
  zone_id    = aws_route53_zone.route53_zone.zone_id
  name       = "${var.subdomain_name}.${var.domain_name}"
  type       = var.record_type
  ttl        = var.ttl_time
  records    = [for ec2 in module.ec2.output_instance_public_ip : ec2]
  depends_on = [module.ec2.main]
}