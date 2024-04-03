variable "ami" {
  description = "nombre de la ami de instancia ec2"
  type        = string
  default     = "ami-0aa7d40eeae50c9a9"
  nullable    = false
  # validation {
  #   condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
  #   error_message = "la variable ami_instancia_ec2 debe tener id de una AMI valida, que comienza con \"ami-\"."
  # }
}

variable "instance_type" {
  description = "nombre del tipo de instancia ec2"
  type        = string
  default     = "t2.micro"
  nullable    = false
}
# esta variable se usar para mapear todas las zonas de disponibilidad,
# en especifico para aplicar la infraestructura
variable "mapeo_zonas_especificas" {
  description = "El mapeo de zonas de disponibilidad en especifico en donde se va desplegar la infraestructura"
  type        = map(any)
  default = {
    "us-east-2a" = "use2-az1"
    "us-east-2b" = "use2-az2"
  }
  nullable = false
}
