variable "secret_credentials_dockerhub" {
  type        = string
  description = "arn del secreto para credenciales de dockerhub"
  default     = "dockerhub-devops"
  nullable    = false
}

variable "codestar_credentials_connector" {
  type        = string
  description = "arn de las credenciales para el codestar connector"
  default     = "issac-devops"
  nullable    = false
}