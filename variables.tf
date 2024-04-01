#variable para la clave publica
variable "access_key" {
  description = "llave publica"
  type        = string
  sensitive   = true
  nullable = false
}
#variable para la clave secreta
variable "secret_key" {
  description = "llave secreta"
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
#esta variable se usa en todos los recursos y contiene toda la información general del proyecto 
variable "tags_general" {
  description = "Tags generales del despliegue por cada proyecto"
  nullable = false
  type = object ({
        proyecto = string
        ambiente = string
        region   = map(string)
        alias    = map(string)
        version  = number
        fecha    = string
    })
  default = {
        proyecto = "devops_prueba"
        ambiente = "dev"
        region = {
        "virginia"  = "us-east-1", 
        "oregon"      = "us-west-2"
        }
        alias = {
        "virginia"  = "east", 
        "ohio"      = "west"
        }
        version  = 1
        fecha   = "2024-04-01"
    }
}