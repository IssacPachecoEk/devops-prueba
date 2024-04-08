variable "s3_artifact_name" {
  description = "Nombre del bucket para los artefactos"
  type        = string
  default     = "devops-bucket-artefactos-2024"
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
    project     = "terraform-devops-prueba"
    environment = "dev"
    version     = "1.0.0"
  }
}