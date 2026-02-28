# Filters
resource "cloudflare_ruleset" "firewall" {
  zone_id = cloudflare_zone.nfowler_dev.id
  name = "custom rules"
  description = "custom firewall rules"
  kind = "zone"
  phase = "http_request_firewall_custom"

  rules {
    action = "block"
    expression = "(cf.edge.server_port ne 80 and cf.edge.server_port ne 443)"
    enabled = true
    description = "block non standard ports"
  }

  rules {
    action = "block"
    expression = "(ip.geoip.country ne \"AU\")"
    enabled = true
    description = "block non au access"
  }

  rules {
    action = "block"
    expression = "(cf.client.bot)"
    enabled = true
    description = "block bots"
  }

  rules {
    action = "managed_challenge"
    expression = "(cf.threat_score gt 14)"
    enabled = true
    description = "challenge threats"
  }
}

