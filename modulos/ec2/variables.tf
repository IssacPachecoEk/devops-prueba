variable "ami_instancia_ec2" {
  description = "nombre de la ami de instancia ec2"
  type        = string
  default     =  ""
}

variable "tipo_instancia_ec2" {
  description = "nombre del tipo de instancia ec2"
  type        = string
  default     =  "t2.micro"
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
}
