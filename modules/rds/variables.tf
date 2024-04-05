variable "identifier_rds" {
  description = "CIDR de la vpc"
  type        = string
  default     = "devops"
  nullable    = false
}
variable "db_name_rds" {
  description = "CIDR de la vpc"
  type        = string
  default     = "mypostgres"
  nullable    = false
}
variable "allocated_storage_rds" {
  description = "el tamaño del almacenamiento"
  type        = number
  default     = 10
  nullable    = false
}
variable "engine_rds" {
  description = "CIDR de la vpc"
  type        = string
  default     = "postgres"
  nullable    = false
}
variable "engine_version_rds" {
  description = "CIDR de la vpc"
  type        = string
  default     = "14"
  nullable    = false
}
variable "instance_claas_rds" {
  description = "CIDR de la vpc"
  type        = string
  default     = "db.m5d.large"
  nullable    = false
}
variable "username_rds" {
  description = "CIDR de la vpc"
  type        = string
  default     = "foo"
  nullable    = false
}
variable "password_rds" {
  description = "CIDR de la vpc"
  type        = string
  default     = "foobarbaz"
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
    version = "1.0.0"
  }
}