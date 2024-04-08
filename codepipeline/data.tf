# obtiene el arn del secreto en donde se encuentra las crendenciales de dockerhub
data "aws_secretsmanager_secret" "credentials_dockerhub" {
  name = var.secret_credentials_dockerhub
}
# obtiene el arn del codestar connection para poder acceder al repositorio de github
data "aws_codestarconnections_connection" "credentials_codestar" {
  name = var.codestar_credentials_connector
}