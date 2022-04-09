# Configures generic users to to access various resources

resource "aws_iam_user" "backups_readwrite_user" {
  name = "cluster-backups-readwrite"
  tags = {
    description = "user to write/read backups made by home cluster"
  }
}

