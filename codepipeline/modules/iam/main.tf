# se define el rol para definir las funciones y permisos que pueden asumir codepipeline y codebuild
resource "aws_iam_role" "codepipeline_role" {
  name        = "${var.project_name}-codepipeline-role"
  description = "rol para definir las funciones y permisos que pueden asumir codepipeline y codebuild"
  tags        = var.common_tag
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "CODEPIPELINEAssumeRole"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "CODEBUILDAssumeRole"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}
# se define la política para permitir la ejecución de codepipeline
resource "aws_iam_policy" "codepipeline_policy" {
  name        = "${var.project_name}-codepipeline-policy"
  path        = "/"
  description = "Política para permitir la ejecución de codepipeline"
  tags        = var.common_tag
  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "codestar-connections:UseConnection",
          ]
          Effect   = "Allow"
          Resource = "arn:aws:codestar-connections:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:connection/*"
        },
        {
          Action = [
            "*",
          ]
          Effect   = "Allow"
          Resource = "*"
        },
        # {
        #   Action = [
        #     "secretsmanager:*",
        #   ]
        #   Effect   = "Allow"
        #   Resource = "*"
        # },
        # {
        #   Action = [
        #     "s3:*",
        #   ]
        #   Effect   = "Allow"
        #   Resource = "${var.s3_bucket_arn}/*"
        # },
        # {
        #   Action = [
        #     "codebuild:*",
        #   ]
        #   Effect   = "Allow"
        #   Resource = "*"
        # },
        # {
        #   Action = [
        #     "cloudwatch:*"
        #   ]
        #   Effect   = "Allow"
        #   Resource = "*"
        # },
        # {
        #   Action = [
        #     "logs:*"
        #   ]
        #   Effect   = "Allow"
        #   Resource = "*"
        # },
        # {
        #   Action = [
        #     "ec2:*"
        #   ]
        #   Effect   = "Allow"
        #   Resource = "*"
        # },
        # {
        #   Action = [
        #     "rds:*"
        #   ]
        #   Effect   = "Allow"
        #   Resource = "*"
        # }
      ]
  })
}
# se atacha el rol a la politica del codepipeline
resource "aws_iam_role_policy_attachment" "codepipeline_role_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}