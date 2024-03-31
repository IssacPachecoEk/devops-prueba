#
output "id_vpc" {
  value = data.aws_iam_policy_document.mi_vpc.id
}