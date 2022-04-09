terraform {
  backend "s3" {
    bucket = "tf-state-nfowl"
    key    = "aws/terraform.tfstate"
    region = "ap-southeast-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure aws to use ap-southeast-2 (sydney)
provider "aws" {
  region = "ap-southeast-2"
  default_tags {
    tags = {
      terraform-managed = "managed by terraform"
    }
  }
}
