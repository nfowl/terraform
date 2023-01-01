resource "cloudflare_zone" "nfowler_dev" {
  account_id = local.account_id
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = "nfowler.dev"
}

resource "cloudflare_zone" "heavens_arena" {
  account_id = local.account_id
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = "heavens-arena.com"
}
