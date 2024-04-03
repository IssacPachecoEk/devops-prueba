variable "bucket_name" {
  description = "Nombre del bucket"
  type        = string
  default     = "devops-prueba"
  nullable    = false
}
variable "bucket_versioning_enabled" {
  description = "Estado del versionamiento del bucket"
  type        = string
  default     = "Enabled"
  nullable    = false
}
variable "bucket_block_public_acls" {
  description = "Estado del acceso publico del bucket"
  type        = bool
  default     = true
  nullable    = false
}
variable "bucket_block_public_policy" {
  description = "Estado de la politica publica del bucket"
  type        = bool
  default     = true
  nullable    = false
}
variable "bucket_ignore_public_acls" {
  description = "Estado para ignorar acl publicas del bucket"
  type        = bool
  default     = true
  nullable    = false
}
variable "bucket_restrict_public_buckets" {
  description = "Estado para restringir que sea publico el bucket"
  type        = bool
  default     = true
  nullable    = false
}
variable "bucket_object_ownership" {
  description = "El tipo de propietario del bucket"
  type        = string
  default     = "BucketOwnerPreferred"
  nullable    = false
}
variable "bucket_acl" {
  description = "Estado acl del bucket"
  type        = string
  default     = "private"
  nullable    = false
}

variable "tags_bucket" {
  description = "etiquetas generales del despliegue"
  nullable    = false
  type = object({
    proyecto = string
    ambiente = string
    region   = map(string)
    alias    = map(string)
    version  = string
  })
  default = {
    proyecto = "devops_prueba"
    ambiente = "dev"
    region = {
      "virginia" = "us-east-1",
      "ohio"     = "us-east-2"
    }
    alias = {
      "virginia" = "east-1",
      "ohio"     = "east-2"
    }
    version = "1.0.0"
  }
}
