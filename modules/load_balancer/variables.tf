variable "alb_namesaa" {
  type = map(string)
  default = {
    for alb_names in ["test1", "test2"] : alb_names => alb_names
  }
}
variable "lb_name" {
  description = "nombre del lb"
  type        = string
  default     = "devops-prueba"
  nullable    = false
}

variable "lb_internal" {
  description = "si se deseas un LB interno"
  type        = bool
  default     = false
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
  description = "puerto del tráfico entrante"
  type        = string
  default     = "443"
  nullable    = false
}

variable "lb_listener_protocol" {
  description = "protocolo de tráfico entrante"
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
  default     = "devops-prueba"
  nullable    = false
}
variable "common_tag" {
  description = "etiquetas generales del despliegue"
  nullable    = false
  type = object({
    project     = string
    environment = string
    region      = map(string)
    alias       = map(string)
    version     = string
  })
  default = {
    project     = "devops_prueba"
    environment = "dev"
    region = {
      "virginia" = "us-east-1",
      "ohio"     = "us-east-2"
    }
    alias = {
      "virginia" = "east-1",
      "ohio"     = "east-2"
    }
    version = "1.0.0"
  }
}