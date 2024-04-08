terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.43.0"
    }
  }
  required_version = "~>1.7.5"
}
provider "aws" {
  region = local.region["virginia"]
  alias  = "virginia"
  default_tags {
    tags = local.common_tag
  }
}
module "s3_artifacts_bucket" {
  source           = "./modules/s3"
  s3_artifact_name = "devops-bucket-artefactos-2024"
  common_tag       = local.common_tag
}
module "codepipeline_iam_role" {
  source        = "./modules/iam"
  project_name  = "terraform-devops-prueba"
  s3_bucket_arn = module.s3_artifacts_bucket.s3_artifact_arn
  common_tag    = local.common_tag
}
module "codebuild_terraform" {
  source                              = "./modules/codebuild"
  project_name                        = "terraform-devops-prueba"
  codebuild_role_arn                  = module.codepipeline_iam_role.role_arn # checar
  credential_registry_credential      = data.aws_secretsmanager_secret.credentials_dockerhub.arn
  build_projects                      = ["plan", "apply-destroy"]
  type_build_project                  = "CODEPIPELINE"
  builder_compute_type                = "BUILD_GENERAL1_SMALL"
  builder_image                       = "hashicorp/terraform:1.7"
  builder_type                        = "LINUX_CONTAINER"
  builder_image_pull_credentials_type = "SERVICE_ROLE"
  common_tag                          = local.common_tag
}

module "codepipeline_terraform" {
  depends_on = [
    module.codebuild_terraform,
    module.s3_artifacts_bucket
  ]
  source                            = "./modules/codepipeline"
  credentials_codestar_codepipeline = data.aws_codestarconnections_connection.credentials_codestar.arn
  name_codepipeline                 = "terraform-devops-prueba"
  type_codepipeline                 = "V2"
  source_repo_name                  = "IssacPachecoEk/devops-prueba"
  source_repo_branch                = "main"
  s3_artifact_codepipeline          = module.s3_artifacts_bucket.s3_artifact_id
  codepipeline_role_arn             = module.codepipeline_iam_role.role_arn # checar
  stages = [
    {
      name             = "Plan"
      name_action      = "Build"
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
      output_artifacts = "build_output_deploy_destroy"
      version          = "1"
      ProjectName      = "apply-destroy"
    }
  ]
  common_tag = local.common_tag
}