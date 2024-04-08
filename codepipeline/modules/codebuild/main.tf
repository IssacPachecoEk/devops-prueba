# se define el codebuild de los stages
resource "aws_codebuild_project" "terraform_codebuild_project" {

  count = length(var.build_projects)

  name         = "${var.project_name}-${var.build_projects[count.index]}"
  service_role = var.codebuild_role_arn
  tags         = var.common_tag
  artifacts {
    type = var.type_build_project
  }
  environment {
    compute_type                = var.builder_compute_type
    image                       = var.builder_image
    type                        = var.builder_type
    privileged_mode             = true
    image_pull_credentials_type = var.builder_image_pull_credentials_type
    registry_credential {
      credential          = var.credential_registry_credential
      credential_provider = "SECRETS_MANAGER"
    }
  }
  source {
    type      = var.type_build_project
    buildspec = file("buildspec/buildspec-${var.build_projects[count.index]}.yml")
  }
}