output "role_arn" {
  value       = aws_iam_role.codepipeline_role.arn
  description = "rol para definir las funciones y permisos que pueden asumir codepipeline y codebuild"
}