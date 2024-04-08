variable "project_name" {
  description = "etiquetas generales del despliegue"
  type        = string
  default     = "terraform-devops-prueba"
  nullable    = false
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 Bucket"
  type        = string
  default     = ""
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