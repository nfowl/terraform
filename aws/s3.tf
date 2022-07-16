# For time being disable all public access for all buckets
resource "aws_s3_account_public_access_block" "s3_account_private_buckets" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "cluster_backups" {
  bucket = "nfowl-cluster-backups"
}

resource "aws_s3_bucket_acl" "cluster_backups_acl" {
  bucket = aws_s3_bucket.cluster_backups.id
  acl    = "private"
}

data "aws_iam_policy_document" "cluster_backups_policy_doc" {
  statement {
    principals {
      type = "AWS"
      identifiers = [
        aws_iam_user.backups_readwrite_user.arn
      ]
    }

    resources = [
      "${aws_s3_bucket.cluster_backups.arn}"
    ]

    actions = [
      "s3:*"
    ]
  }
}

resource "aws_s3_bucket_policy" "cluster_backups_policy" {
  policy = data.aws_iam_policy_document.cluster_backups_policy_doc.json
  bucket = aws_s3_bucket.cluster_backups.id
}

data "aws_iam_policy_document" "cluster_backups_user_readwrite_doc" {
  statement {
    resources = [
      "${aws_s3_bucket.cluster_backups.arn}"
    ]

    actions = [
      "s3:*"
    ]
  }
}

resource "aws_iam_user_policy" "cluster_backups_bucket_readwrite" {
  name   = "cluster-backups-s3-bucket-write"
  policy = data.aws_iam_policy_document.cluster_backups_user_readwrite_doc.json
  user   = aws_iam_user.backups_readwrite_user.id
}

module "generic_bucket" {
  source           = "./helpers/bucket"
  bucket_name      = "nfowl-generic"
  bucket_user_arn  = aws_iam_user.general_storage_user.arn
  bucket_user_name = aws_iam_user.general_storage_user.id
}
