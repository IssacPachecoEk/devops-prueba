#variable para la clave secreta
variable "alias" {
  description = "el alias de la region"
  type        = string
  default     = "nort virginia"
}
#variable para la clave publica
variable "access_key" {
  description = "llave publica"
  type        = string
  sensitive   = true
}
#variable para la clave secreta
variable "secret_key" {
  description = "llave secreta"
  type        = string
  sensitive   = true
}
variable "role_arn_backend" {
  description = "el arn del rol para almacenar el backend del despliegue en el bucket"
  type        = string
  sensitive   = true
}
variable "profile_backend" {
  description = "el arn del rol para almacenar el backend del despliegue en el bucket"
  type        = string
  sensitive   = true
}
#esta variable contiene toda la información general de todos los recursos
variable "tags_general" {
  description = "Tags generales del despliegue"
  type = object ({
        proyecto = string
        ambiente = string
        region = string
        version = number
        fecha = string
    })
}