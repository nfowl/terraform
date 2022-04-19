data "http" "ipv4" {
  url = "http://ipv4.icanhazip.com"
}

variable "worker_dns_records" {
  type        = set(string)
  description = "list of domains to make dummy dns records for"
}

resource "cloudflare_record" "root_a" {
  name    = "nfowler.dev"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = chomp(data.http.ipv4.body)
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "alertmanager_cname" {
  name    = "alertmanager"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "bitwarden_cname" {
  name    = "bitwarden"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "dashboard_cname" {
  name    = "dashboard"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "google_required_cname" {
  name    = "_domainconnect"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "connect.domains.google.com"
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "drone_cname" {
  name    = "drone"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "flood_cname" {
  name    = "flood"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "gitea_cname" {
  name    = "gitea"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "grafana_cname" {
  name    = "grafana"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "jackett_cname" {
  name    = "jackett"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "jellyfin_cname" {
  name    = "jellyfin"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "lidarr_cname" {
  name    = "lidarr"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "meruem_cname" {
  name    = "meruem"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "minio_cname" {
  name    = "minio"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "nextcloud_cname" {
  name    = "nextcloud"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "radarr_cname" {
  name    = "radarr"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "registry_cname" {
  name    = "registry"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "sonarr_cname" {
  name    = "sonarr"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "testing_cname" {
  name    = "testing"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "transmission_cname" {
  name    = "transmission"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "unifi_cname" {
  name    = "unifi"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

# Dummy records to allow worker only paths to get routed correctly
resource "cloudflare_record" "workers_a" {
  for_each = var.worker_dns_records
  name     = each.key
  proxied  = true
  ttl      = 1
  type     = "A"
  value    = "192.0.2.1"
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "www_cname" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = cloudflare_record.root_a.hostname
  zone_id = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "cloudflare_mail_mx_amir" {
  name     = "nfowler.dev"
  priority = 81
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "amir.mx.cloudflare.net"
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "cloudflare_mail_mx_linda" {
  name     = "nfowler.dev"
  priority = 22
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "linda.mx.cloudflare.net"
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "cloudflare_mail_mx_isaac" {
  name     = "nfowler.dev"
  priority = 60
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "isaac.mx.cloudflare.net"
  zone_id  = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_record" "cloudflare_mail_vpf" {
  name    = "nfowler.dev"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  zone_id = cloudflare_zone.nfowler_dev.id
}
