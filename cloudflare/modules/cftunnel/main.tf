terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

resource "cloudflare_tunnel_config" "tunnel_config" {
  account_id = var.zone.account_id
  tunnel_id  = var.tunnel.id
  config {
    origin_request {
      http_host_header = "${var.hostname}.${var.zone.zone}"
    }
    ingress_rule {
      hostname = "${var.hostname}.${var.zone.zone}"
      service  = var.ingress_target
    }
    ingress_rule {
      # catch all required
      service = "http_status:404"
    }
  }
}

resource "cloudflare_record" "dns_record" {
  zone_id = var.zone.id
  name    = var.hostname
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = var.tunnel.cname
}
