terraform {
  backend "s3" {
    bucket = "tf-state-nfowl"
    key    = "aws/terraform.tfstate"
    region = "ap-southeast-2"
  }
}
