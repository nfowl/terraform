variable "bucket_name" {
  description = "name of the s3 bucket"
  type        = string
}

variable "bucket_user_arn" {
  type        = string
  description = "user who can interact with the bucket"
}

variable "bucket_user_name" {
  type        = string
  description = "name of the bucket user"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

data "aws_iam_policy_document" "bucket_policy_doc" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        var.bucket_user_arn
      ]
    }

    resources = [
      "${aws_s3_bucket.bucket.arn}"
    ]

    actions = [
      "s3:*"
    ]
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  policy = data.aws_iam_policy_document.bucket_policy_doc.json
  bucket = aws_s3_bucket.bucket.id
}

data "aws_iam_policy_document" "bucket_user_policy_doc" {
  statement {
    resources = [
      "${aws_s3_bucket.bucket.arn}"
    ]

    actions = [
      "s3:*"
    ]
  }
}

resource "aws_iam_user_policy" "bucket_user_policy" {
  name   = "${var.bucket_name}-bucket-write"
  policy = data.aws_iam_policy_document.bucket_user_policy_doc.json
  user   = var.bucket_user_name
}
