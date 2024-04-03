variable "ttl" {
  description = "el tiempo de vida del registro DNS"
  type        = number
  default     = 300
  nullable = false
}
variable "tipo_registro" {
  description = "el tipo de registro DNS"
  type        = string
  default     = "CNAME"
  nullable = false
}
variable "nombre_dominio_route" {
  description = "nombre del dominio"
  type        = string
  default     = "devopspruebadev.com"
  nullable = false
}
variable "zona_privada_route" {
  description = "define si el dns es privado o no"
  type        = bool
  default     = false
  nullable = false
}