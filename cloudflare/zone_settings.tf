resource "cloudflare_zone_settings_override" "nfowler_dev" {
  zone_id = cloudflare_zone.nfowler_dev.id
  settings {
    minify {
      css  = "on"
      html = "on"
      js   = "on"
    }
    security_header {
      enabled            = false
      include_subdomains = false
      max_age            = 0
      nosniff            = false
      preload            = false
    }
    always_use_https            = "on"
    automatic_https_rewrites    = "on"
    brotli                      = "on"
    http3                       = "on"
    ipv6                        = "on"
    min_tls_version             = "1.2"
    opportunistic_encryption    = "on"
    opportunistic_onion         = "on"
    pseudo_ipv4                 = "off"
    ssl                         = "strict"
    tls_1_3                     = "on"
    tls_client_auth             = "off"
    websockets                  = "on"
  }
}