variable "name_codepipeline" {
  type        = string
  description = "nombre del codepipeline"
  default     = "terraform-devops-prueba"
  nullable    = false
}
variable "type_codepipeline" {
  type        = string
  description = "el tipo de version del codepipeline"
  default     = "V2"
  nullable    = false
}
variable "codepipeline_role_arn" {
  type        = string
  description = "arn del rol de codepipeline para permisos"
  default     = ""
  nullable    = false
}
variable "s3_artifact_codepipeline" {
  type        = string
  description = "el id del bucket s3 para los artefactos"
  default     = ""
  nullable    = false
}

variable "credentials_codestar_codepipeline" {
  type        = string
  description = "arn de las credenciales para el codestar connector"
  default     = ""
  nullable    = false
}

variable "source_repo_name" {
  type        = string
  description = "nombre del repositorio github a despelgar"
  default     = "IssacPachecoEk/devops-prueba"
  nullable    = false
}

variable "source_repo_branch" {
  type        = string
  description = "nombre de la rama a despelgar"
  default     = "main"
  nullable    = false
}

variable "stages" {
  description = "List of Map containing information about the stages of the CodePipeline"
  type        = list(map(string))
  default = [
    {
      name             = "Plan"
      name_action      = "Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = "source_output"
      output_artifacts = "build_output_plan"
      version          = "1"
      ProjectName      = "plan"
    },
    {
      name             = "Deploy"
      name_action      = "Deploy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = "source_output"
      output_artifacts = "build_output_apply_destroy"
      version          = "1"
      ProjectName      = "apply-destroy"
    }
  ]
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