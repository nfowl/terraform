resource "cloudflare_zone" "nfowler_dev" {
  paused = false
  plan   = "free"
  type   = "full"
  zone   = "nfowler.dev"
}

resource "cloudflare_zone" "heavens_arena" {
  paused = false
  plan   = "free"
  type   = "full"
  zone   = "heavens-arena.com"
}