variable "name_domain_certificate" {
  description = "Nombre del certificado para dominio"
  type        = string
  default     = "devopspruebaexamen.com"
  nullable    = false
}
variable "subdomain_domain_certificate" {
  description = "nombre del certificado para subdominio"
  type        = string
  default     = "subdominio"
  nullable    = false
}
variable "validation_method" {
  description = "Metodo de validacion del certificado"
  type        = string
  default     = "DNS"
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