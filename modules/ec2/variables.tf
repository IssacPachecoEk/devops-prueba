variable "ami_ec2" {
  description = "nombre de la ami de instancia ec2"
  type        = string
  default     = "ami-0aa7d40eeae50c9a9"
  nullable    = false
  # validation {
  #   condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
  #   error_message = "la variable ami_instancia_ec2 debe tener id de una AMI valida, que comienza con \"ami-\"."
  # }
}
# el tipo de instancia ec2
variable "instance_type_ec2" {
  description = "tipo de instancia ec2"
  type        = string
  default     = "t2.micro"
  nullable    = false
}
# llaves para conectarse al ec2
variable "key_pair_ec2" {
  description = "llaves para conectarse al ec2"
  type        = string
  default     = "key-pair-issac"
  nullable    = false
}

variable "common_tag" {
  description = "etiquetas generales del despliegue"
  nullable    = false
  type = object({
    project     = string
    environment = string
    version     = string
  })
  default = {
    project     = "devops_prueba"
    environment = "dev"
    version     = "1.0.0"
  }
}