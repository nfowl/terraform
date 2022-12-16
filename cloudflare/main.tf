terraform {
  backend "s3" {
    bucket = "tf-state-nfowl"
    key    = "cloudflare/terraform.tfstate"
    region = "ap-southeast-2"
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }
}
