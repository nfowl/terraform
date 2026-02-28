terraform {
  backend "s3" {
    bucket = "tf-state-nfowl"
    key    = "cloudflare/terraform.tfstate"
    region = "ap-southeast-2"
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}

locals {
  account_id  = "995eaad470a53a7070ca543fa34340ae"
  ingress_ip  = "http://192.168.1.20"
  auth_tunnel = "a0bb083a-1b96-4b6f-8926-bd4b7f939844.cfargotunnel.com"
}

provider "cloudflare" {}
