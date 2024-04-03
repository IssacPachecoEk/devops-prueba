variable "nombre_dominio_certificado" {
  description = "Nombre del certificado para dominio"
  type        = string
  default     = "devopspruebadev.com"
  nullable = false
}
variable "metodo_validacion" {
  description = "Metodo de validacion del certificado"
  type        = string
  default     = "DNS"
  nullable = false
}