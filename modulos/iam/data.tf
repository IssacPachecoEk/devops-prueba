# data con la politica para el bucket s3 del backend
data "aws_iam_policy_document" "iam_politica_bucket" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["123456789012"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.bucket_backend.arn,
      "${aws_s3_bucket.bucket_backend.arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}
