variable "vpc_cidr_block" {
  description = "CIDR de la vpc"
  type        = string
  default     = "10.10.0.0/16"
  nullable    = false
}
variable "vpc_map_public_ip_on_launch" {
  description = "valida asignación un dirección IP pública"
  type        = bool
  default     = true
  nullable    = false
}

variable "vpc_route_table_cidr_block" {
  description = "tabla de enrutamiento"
  type        = string
  default     = "0.0.0.0/0"
  nullable    = false
}

variable "vpc_sg_name_instance" {
  description = "Nombre del grupo de seguridad de la instancia"
  type        = string
  default     = "grupo-seguridad-devops"
  nullable    = false
}

variable "ingress_ports_list" {
  description = "Lista de puertos del ingress por SSH Y HTTP"
  type        = list(number)
  default     = [80, 22, 5432]
  nullable    = false
}

variable "ingress_protocol" {
  description = "El tipo de protocolo del ingress"
  type        = string
  default     = "tcp"
  nullable    = false
}

variable "sg_ingress_cidr_blocks" {
  description = "CIDR para el trafico del ingress"
  type        = string
  default     = "0.0.0.0/0"
  nullable    = false
}

variable "egress_port" {
  description = "Lista de puertos del egress por SSH Y HTTP"
  type        = number
  default     = 0
  nullable    = false
}

variable "egress_protocol" {
  description = "El tipo de protocolo del egress"
  type        = string
  default     = "-1"
  nullable    = false
}

variable "sg_egress_cidr_blocks" {
  description = "CIDR para el trafico del egress"
  type        = string
  default     = "0.0.0.0/0"
  nullable    = false
}

variable "common_tag" {
  description = "etiquetas generales del despliegue"
  nullable    = false
  type = object({
    project     = string
    environment = string
    version     = string
  })
  default = {
    project     = "devops_prueba"
    environment = "dev"
    version = "1.0.0"
  }
}