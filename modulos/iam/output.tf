#esta salida retorna el id de la politica del bucket para backend
output "iam_politica_bucket" {
  value = data.aws_iam_policy_document.iam_politica_bucket.id
}