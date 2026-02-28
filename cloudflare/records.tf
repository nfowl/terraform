variable "worker_dns_records" {
  type        = set(string)
  description = "list of domains to make dummy dns records for"
}

variable "tunneled_hostnames" {
  type        = set(string)
  description = "tunneled hosts"
}

resource "cloudflare_record" "google_required_cname" {
  name    = "_domainconnect"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  content = "connect.domains.google.com"
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "tunneled_hostnames" {
  for_each = var.tunneled_hostnames
  name     = each.key
  proxied  = true
  ttl      = 1
  type     = "CNAME"
  content  = local.auth_tunnel
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "root" {
  name    = "@"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  content = local.auth_tunnel
  zone_id = cloudflare_zone.nfowler_dev.id
}

# Dummy records to allow worker only paths to get routed correctly
resource "cloudflare_record" "workers_a" {
  for_each = var.worker_dns_records
  name     = each.key
  proxied  = true
  ttl      = 1
  type     = "A"
  content  = "192.0.2.1"
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "cloudflare_mail_mx_amir" {
  name     = "nfowler.dev"
  priority = 81
  proxied  = false
  ttl      = 1
  type     = "MX"
  content  = "amir.mx.cloudflare.net"
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "cloudflare_mail_mx_linda" {
  name     = "nfowler.dev"
  priority = 22
  proxied  = false
  ttl      = 1
  type     = "MX"
  content  = "linda.mx.cloudflare.net"
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "cloudflare_mail_mx_isaac" {
  name     = "nfowler.dev"
  priority = 60
  proxied  = false
  ttl      = 1
  type     = "MX"
  content  = "isaac.mx.cloudflare.net"
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "cloudflare_mail_vpf" {
  name    = "nfowler.dev"
  proxied = false
  ttl     = 1
  type    = "TXT"
  content = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  zone_id = cloudflare_zone.nfowler_dev.id
}
