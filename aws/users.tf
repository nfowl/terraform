# Configures generic users to to access various resources

resource "aws_iam_user" "backups_readwrite_user" {
  name = "cluster-backups-readwrite"
  tags = {
    description = "user to write/read backups made by home cluster"
  }
}

resource "aws_iam_user" "general_storage_user" {
  name = "generic-user"
  tags = {
    description = "User to interact with general storage"
  }
}
