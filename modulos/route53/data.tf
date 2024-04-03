data "aws_route53_zone" "route_web_devops" {
  name         = var.nombre_dominio_route
  private_zone = var.zona_privada_route
}
