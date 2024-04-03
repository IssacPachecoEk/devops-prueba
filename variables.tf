#variable para el valor de la clave publica del usuario
variable "location_credentials_file" {
  description = "path en donde se encuentr el archivo de las credenciales"
  type        = string
  sensitive   = true
  nullable = false
}
#variable para el valor de la clave publica del usuario
variable "access_key" {
  description = "llave publica"
  type        = string
  sensitive   = true
  nullable = false
}
#variable para la valor de la clave secreta del usuario
variable "secret_key" {
  description = "llave secreta"
  type        = string
  sensitive   = true
  nullable = false
}
#el nombre del perfil que se esta usando
variable "profile_aws" {
  description = "nombre del perfil de aws"
  type        = string
  sensitive   = true
  nullable = false
}
variable "role_arn_backend" {
  description = "el arn del rol para almacenar el backend del despliegue en el bucket"
  type        = string
  sensitive   = true
  nullable = false
}
variable "profile_backend" {
  description = "el arn del rol para almacenar el backend del despliegue en el bucket"
  type        = string
  sensitive   = true
  nullable = false
}