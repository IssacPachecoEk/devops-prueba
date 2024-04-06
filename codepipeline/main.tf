terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.43.0"
    }
  }
  required_version = "~>1.7.5"
}
resource "aws_codebuild_project" "plan" {
  name          = "plan"
  description   = "Plan stage for terraform"
  build_timeout = 20
  queued_timeout = 20
  service_role  = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:1.7"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential {
      credential          = var.dockerhub_credentials
      credential_provider = "SECRETS_MANAGER"
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = file("buildspec/plan-buildspec.yml")
  }
}

resource "aws_codebuild_project" "apply_destroy" {
  name           = "apply"
  description    = "Apply stage for terraform"
  build_timeout  = 20
  queued_timeout = 20
  service_role   = aws_iam_role.tf-codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.s3_codepipeline_artifacts.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:1.7"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "SERVICE_ROLE"
    registry_credential {
      credential          = var.dockerhub_credentials
      credential_provider = "SECRETS_MANAGER"
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = file("buildspec/apply-destroy-buildspec.yml")
  }
}


resource "aws_codepipeline" "cicd_pipeline" {

  name     = "my-terra-code"
  role_arn = aws_iam_role.tf-codepipeline-role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.s3_codepipeline_artifacts.id
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = var.codestar_connector_credentials
        FullRepositoryId = "IssacPachecoEk/devops-prueba"
        BranchName       = "respaldo"
      }
    }
  }

  stage {
    name = "Plan"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      configuration = {
        ProjectName = aws_codebuild_project.plan.name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["build_output"]
      version         = "1"
      configuration = {
        ProjectName = aws_codebuild_project.apply_destroy.name
      }
    }
  }

}