terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.43.0"
    }
  }
  required_version = "~>1.7.5"
}
# obtiene el repositorio de codecommit creado previamente en la consola de aws
data "aws_codecommit_repository" "repo" {
  repository_name = "terraform-devops-prueba"
}
# recurso para crear el codebuild del proyecto
resource "aws_codebuild_project" "codebuild_project" {
  name         = "codebuild-devops-prueba"
  service_role = aws_iam_role.role_code_build.arn
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type         = "LINUX_CONTAINER"
  }
  source {
    type            = "GITHUB"
    location        = "https://github.com/IssacPachecoEk/devops-prueba.git"
    git_clone_depth = 0
    buildspec       = <<-EOF
      version: 0.2
      phases:
        build:
          commands:
            - terraform version
            - terraform init
            - terraform plan
            - terraform apply --auto-approve
    EOF

    # git_submodules_config {
    #   fetch_submodules = true
    # }
  }
#   source {
#     type            = "CODECOMMIT"
#     location        = data.aws_codecommit_repository.repo.clone_url_http
#     git_clone_depth = 1
#     buildspec       = <<-EOF
#       version: 0.2
#       phases:
#         build:
#           commands:
#             - sudo yum update -y
#             - sudo yum install -y unzip
#             - curl -O https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
#             - unzip terraform_1.7.5_linux_amd64.zip
#             - sudo mv terraform /usr/local/bin/
#             - sudo yum install git
#             - git clone https://github.com/IssacPachecoEk/devops-prueba.git
#             - cd devops-prueba
#             - git checkout respaldo
#             - terraform version
#             - terraform init
#             - terraform apply --auto-approve
#     EOF
#   }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  source_version = "master"
}
# recurso para crear el codepipeline del proyecto
resource "aws_codepipeline" "main" {
  name = "terraform-pipeline-devops-prueba"

  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.backend_bucket.id
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name     = "SourceAction"
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"
    #   configuration = {
    #     RepositoryName = "terraform-devops-prueba"
    #     #BranchName     = "master"
    #   }

      output_artifacts = ["source_artifact"]
    }
  }

  stage {
    name = "Build"

    action {
      name            = "BuildAction"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      input_artifacts = ["source_artifact"]
      configuration = {
        ProjectName = aws_codebuild_project.codebuild_project.name
      }
    }
  }
}