
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
