resource "aws_lb" "example_lb" {
  name               = "example-lb"
  internal           = false  # Cambia esto a true si deseas un LB interno
  load_balancer_type = "application"
  subnets            = ["subnet-12345678", "subnet-87654321"]  # Cambia estas subnets a las deseadas
  # security_groups    = [aws_security_group.lb_sg.id]
  
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

#atachar certificado al alb
resource "aws_lb_listener_certificate" "example" {
  listener_arn    = aws_lb_listener.front_end.arn
  certificate_arn = aws_acm_certificate.example.arn
}

# resource "aws_lb_target_group" "example_lb_target_group" {
#   name     = "example-target-group"
#   port     = 80
#   protocol = "TCP"
# }

# resource "aws_lb_target_group_attachment" "example_lb_target_group_attachment" {
#   target_group_arn = aws_lb_target_group.example_lb_target_group.arn
#   target_id        = aws_instance.example.id
#   port             = 80
# }