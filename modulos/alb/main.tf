module "acm_web_devops" {
  source = "../modulos/acm"
  # version      = local.version
  backend_name = local.bucket_name_sufijo
  tags         = local.common_tag
}

module "vpc_devops_prueba" {
  source = "../modulos/vpc"
  # version        = local.version
  vpc_cidr_block = local.cidr_block
  tags           = local.common_tag
}

module "ec2" {
  source = "../modulos/ec2"
  # version = local.version
  ami  = local.ami
  tags = local.common_tag
}


resource "aws_lb" "lb_name" {
  name               = var.lb_name
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  subnets            = vpc_devops_prueba.output.vpc_public_subnets
  security_groups    = [vpc_devops_prueba.output.vpc_security_group]

  lifecycle {
    create_before_destroy = var.alb_create_before_destroy
  }

  tags = {}
}
# define cómo se debe dirigir el tráfico entrante al ec2
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb_name.arn
  port              = var.lb_listener_port
  protocol          = var.lb_listener_protocol
  ssl_policy        = var.lb_ssl_policy
  certificate_arn   = module.acm_web_devops.output.output_acm_certificate

  default_action {
    type             = var.lb_default_action_type
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

#atachar certificado al alb
resource "aws_lb_listener_certificate" "lb_listener_certificate" {
  listener_arn    = aws_lb_listener.lb_listener.arn
  certificate_arn = module.acm_web_devops.output.output_acm_certificate
}
# crea un grupo de destino.
resource "aws_lb_target_group" "lb_target_group" {
  name     = var.lb_target_group
  port     = 80
  protocol = "HTTP"
}
# asocia instancia específica con el grupo de destino.
resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = module.ec2.instancia_ec2_web_devops.id
  port             = 80
}
