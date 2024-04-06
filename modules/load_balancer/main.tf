module "certificate" {
  source                       = "../certificate"
  name_domain_certificate      = "devopspruebaexamen.com"
  subdomain_domain_certificate = "subdominio"
  validation_method            = "DNS"
  tags                         = var.common_tag
}
module "ec2" {
  source            = "../ec2"
  ami_ec2           = "ami-0aa7d40eeae50c9a9"
  instance_type_ec2 = "t2.micro"
  key_pair_ec2      = "key-pair-issac"
  tags              = var.common_tag
}
# principal recurso
resource "aws_lb" "main" {
  for_each           = var.alb_namesaa
  name               = each.value #var.lb_name
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = [module.ec2.output_security_group]
  subnets            = [for subnet in module.ec2.output_subnet_public : subnet]
  # habilitar para proteger la instancia contra la eliminación accidental.
  enable_deletion_protection = false
  # lifecycle {
  # si el valor esta en true, primero crea un nuevo recurso con la configuración actualizada antes de destruir el recurso existente. 
  # Esto garantiza que haya un recurso disponible en todo momento durante el proceso de actualización,
  # lo que minimiza el tiempo de inactividad.
  #   create_before_destroy = var.alb_create_before_destroy 
  # }
  tags = var.common_tag
}
# crea un grupo de destino.
resource "aws_lb_target_group" "grupo_destino" {
  for_each    = var.alb_namesaa
  name        = each.value #var.lb_target_group
  target_type = "instance"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = module.ec2.output_aws_vpc_id
  tags        = var.common_tag
}
# define como se debe dirigir el tráfico entrante al ec2
resource "aws_lb_listener" "lb_listener" {
  for_each          = var.alb_namesaa
  load_balancer_arn = aws_lb.main[each.value].id
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  ssl_policy        = var.lb_ssl_policy
  certificate_arn   = module.certificate.output_certificate

  default_action {
    type             = var.lb_default_action_type
    target_group_arn = aws_lb_target_group.grupo_destino[each.value].id
  }
  tags = var.common_tag
}
# atachar certificado al alb
resource "aws_lb_listener_certificate" "lb_listener_certificate" {
  for_each        = { for idx, ec2_id in module.ec2.output_aws_instance_id : idx => ec2_id }
  listener_arn    = aws_lb_listener.lb_listener[each.value].arn
  certificate_arn = module.certificate.output_certificate
  depends_on      = [module.certificate.main]
  tags            = var.common_tag
}
# asocia instancia específica con el grupo de destino.
resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  for_each         = { for idx, ec2_id in module.ec2.output_aws_instance_id : idx => ec2_id }
  target_group_arn = aws_lb_target_group.grupo_destino[each.value].id # checar
  target_id        = each.value
  port             = 443
  depends_on       = [module.ec2.main]
  tags             = var.common_tag
}