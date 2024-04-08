# obtiene la region actual
data "aws_region" "current" {}
# obtiene el indentificador de la cuenta
data "aws_caller_identity" "current" {}
# obtiene la partición actual de aws
data "aws_partition" "current" {}