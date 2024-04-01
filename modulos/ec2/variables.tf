variable "ami_instancia_ec2" {
  description = "nombre de la ami de instancia ec2"
  type        = string
  default     =  ""
  nullable = false
  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "la variable ami_instancia_ec2 debe tener id de una AMI valida, que comienza con \"ami-\"."
  }
}

variable "tipo_instancia_ec2" {
  description = "nombre del tipo de instancia ec2"
  type        = string
  default     =  "t2.micro"
  nullable = false
}
# esta variable se usar para mapear todas las zonas de disponibilidad,
# en especifico para aplicar la infraestructura
variable "mapeo_zonas_especificas" {
  description = "El mapeo de zonas de disponibilidad en especifico en donde se va desplegar
  la infraestructura"
  type        = map
  default     = {
    "us-east-1a" = "use1-az1"
    "us-east-1b" = "usw2-az2"
  }
  nullable = false
}
