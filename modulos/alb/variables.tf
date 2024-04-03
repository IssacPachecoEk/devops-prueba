variable "lb_name" {
  description = "nombre del lb"
  type        = string
  default     = "lb_devops_prueba"
  nullable    = false
}

variable "lb_internal" {
  description = "si se deseas un LB interno"
  type        = bool
  default     = fale
  nullable    = false
}

variable "lb_type" {
  description = "el tipo del balanceador"
  type        = string
  default     = "application"
  nullable    = false
}

variable "alb_create_before_destroy" {
  description = "define si crea antes de destruir el recurso nuevo"
  type        = bool
  default     = false
  nullable    = false
}

variable "lb_listener_port" {
  description = "politica de seguridad SSL"
  type        = string
  default     = "HTTPS"
  nullable    = false
}

variable "lb_listener_protocol" {
  description = "politica de seguridad SSL"
  type        = string
  default     = "HTTPS"
  nullable    = false
}

variable "lb_ssl_policy" {
  description = "politica de seguridad SSL"
  type        = string
  default     = "ELBSecurityPolicy-2016-08"
  nullable    = false
}

variable "lb_default_action_type" {
  description = "define el tráfico entrante que coincide con este listener"
  type        = string
  default     = "forward"
  nullable    = false
}

variable "lb_target_group" {
  description = "define el grupo de destino"
  type        = string
  default     = "target-group-devops-prueba"
  nullable    = false
}
