variable "project_name" {
  description = "prefijo del proyecto"
  type        = string
  default     = "terraform-devops-prueba"
  nullable    = false
}
variable "build_projects" {
  description = "Lista de nombres de cada codebuild"
  type        = list(string)
  default     = ["plan", "apply-destroy"]
  nullable    = false
}
variable "codebuild_role_arn" {
  description = "arn del rol de codebuild para permisos"
  type        = string
  default     = ""
  nullable    = false
}
variable "type_build_project" {
  description = "se usa para el tipo de artifact y el tipo de source"
  type        = string
  default     = "CODEPIPELINE"
  nullable    = false
}
variable "builder_compute_type" {
  description = "el tipo de computo para construir"
  type        = string
  default     = "BUILD_GENERAL1_SMALL"
  nullable    = false
}
variable "builder_image" {
  description = "La imagen de Docker que se utiliza para compilación"
  type        = string
  default     = "hashicorp/terraform:1.7"
  nullable    = false
}
variable "builder_image_pull_credentials_type" {
  description = "Tipo de credencial que utiliza para la image a compilar"
  type        = string
  default     = "SERVICE_ROLE"
  nullable    = false
}
variable "credential_registry_credential" {
  description = "credenciales para conectar a docker hub"
  type        = string
  default     = ""
  nullable    = false
}
variable "builder_type" {
  description = "Tipo de entorno de compilación que se usa para compilar"
  type        = string
  default     = "LINUX_CONTAINER"
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