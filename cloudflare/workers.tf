# general configuration for the cloudflare workers
# Main script is handled via wrangler but this will be used to configure as much
# of the remaining options we can without having to include the js

locals {
  account_id = "995eaad470a53a7070ca543fa34340ae"
}

variable "auth_worker_domains" {
  type        = set(string)
  description = "List of domains/routes that the auth worker will listen on"
}

resource "cloudflare_worker_route" "auth_worker_routes" {
  for_each    = var.auth_worker_domains
  pattern     = each.key
  script_name = "cf-worker"
  zone_id     = cloudflare_zone.nfowler_dev.id
}

resource "cloudflare_workers_kv_namespace" "auth_kv_namespace" {
  account_id = local.account_id
  title      = "cf-worker-AUTH_STORE"
}
