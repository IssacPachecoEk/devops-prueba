# crea el rol para tener permisos de codebuild
resource "aws_iam_role" "role_code_build" {
  name               = "codebuil-service-role"
  assume_role_policy = data.aws_iam_policy_document.aws_iam_policy_document.json
}
# obtiene la politica para el rol de codebuild
data "aws_iam_policy_document" "aws_iam_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}
# se atacha el rol de codebuild con permisos de administrador
resource "aws_iam_role_policy_attachment" "attach_codebuild_permissions" {
  role       = aws_iam_role.role_code_build.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
# se crea el rol para codepipeline
resource "aws_iam_role" "codepipeline_role" {
  name               = "codepipeline-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
#  se atacha el rol de codebuild con permisos de administrador
resource "aws_iam_role_policy_attachment" "attach_codepipeline_permissions" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}