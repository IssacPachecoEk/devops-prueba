variable "identifier_rds" {
  description = "el indentificador de la rds"
  type        = string
  default     = "devops"
  nullable    = false
}
variable "db_name_rds" {
  description = "el nombre de la rds"
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
  description = "El motor de base de datos "
  type        = string
  default     = "postgres"
  nullable    = false
}
variable "engine_version_rds" {
  description = "La version del motor de base de datos "
  type        = string
  default     = "14"
  nullable    = false
}
variable "instance_class_rds" {
  description = "El tipo de instancia de la instancia RDS."
  type        = string
  default     = "db.m5d.large"
  nullable    = false
}
variable "username_rds" {
  description = "el usuario de la base de datos"
  type        = string
  default     = "foo"
  nullable    = false
}
variable "password_rds" {
  description = "la contraseña de la base de datos"
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