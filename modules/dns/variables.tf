variable "ttl_time" {
  description = "el tiempo de vida del registro DNS"
  type        = number
  default     = 300
  nullable    = false
}
variable "record_type" {
  description = "el tipo de registro DNS"
  type        = string
  default     = "A"
  nullable    = false
}
variable "domain_name" {
  description = "nombre del dominio"
  type        = string
  default     = "devopspruebaexamen.com"
  nullable    = false
}
variable "subdomain_name" {
  description = "nombre del subdominio"
  type        = string
  default     = "subdominio"
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