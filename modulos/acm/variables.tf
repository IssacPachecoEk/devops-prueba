variable "name_domain_certificado" {
  description = "Nombre del certificado para dominio"
  type        = string
  default     = "devopspruebadev.com"
  nullable    = false
}
variable "validation_method" {
  description = "Metodo de validacion del certificado"
  type        = string
  default     = "DNS"
  nullable    = false
}
