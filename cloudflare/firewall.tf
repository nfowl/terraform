# Filters
resource "cloudflare_filter" "threat_score_filter" {
  expression = "(cf.threat_score gt 14)"
  paused     = false
  zone_id    = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_filter" "verified_bot_filter" {
  expression = "(cf.client.bot)"
  paused     = false
  zone_id    = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_filter" "geoblock_filter" {
  expression = "(ip.geoip.country ne \"AU\")"
  paused     = false
  zone_id    = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_filter" "ports_filter" {
  expression = "(cf.edge.server_port ne 80 and cf.edge.server_port ne 443)"
  paused     = false
  zone_id    = cloudflare_zone.nfowler_dev.id
}

#Rules
resource "cloudflare_firewall_rule" "verified_bot_rule" {
  action      = "block"
  description = "bots"
  filter_id   = cloudflare_filter.verified_bot_filter.id
  paused      = false
  priority    = 1000
  zone_id     = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_firewall_rule" "threat_score_rule" {
  action      = "challenge"
  description = "Threat"
  filter_id   = cloudflare_filter.threat_score_filter.id
  paused      = false
  zone_id     = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_firewall_rule" "geoblock_rule" {
  action      = "block"
  description = "Block International"
  filter_id   = cloudflare_filter.geoblock_filter.id
  paused      = false
  zone_id     = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_firewall_rule" "port_rule" {
  action      = "block"
  description = "Block all non-standard ports"
  filter_id   = cloudflare_filter.ports_filter.id
  paused      = false
  zone_id     = cloudflare_zone.nfowler_dev.id
}
