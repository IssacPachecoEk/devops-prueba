# se define el codepipeline para desplegar el aplicativo
resource "aws_codepipeline" "cicd_pipeline" {
  name          = var.name_codepipeline
  pipeline_type = var.type_codepipeline
  role_arn      = var.codepipeline_role_arn
  tags          = var.common_tag
  artifact_store {
    type     = "S3"
    location = var.s3_artifact_codepipeline
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      run_order        = 1
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn        = var.credentials_codestar_codepipeline
        FullRepositoryId     = var.source_repo_name
        BranchName           = var.source_repo_branch
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }
  dynamic "stage" {
    for_each = var.stages

    content {
      name = "Stage-${stage.value["name"]}"
      action {
        category         = stage.value["category"]
        name             = "Action-${stage.value["name_action"]}"
        owner            = stage.value["owner"]
        provider         = stage.value["provider"]
        input_artifacts  = [stage.value["input_artifacts"]]
        output_artifacts = [stage.value["output_artifacts"]]
        version          = "1"
        run_order        = index(var.stages, stage.value) + 2

        configuration = {
          ProjectName = "${var.name_codepipeline}-${stage.value["ProjectName"]}"
        }
      }
    }
  }
}