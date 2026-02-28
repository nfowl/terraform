
variable "tunnel" {
  type = object({
    id    = string
    cname = string
  })
  description = "The tunnel the config will be attached to"
}

variable "ingress_target" {
  type        = string
  description = "Ingress target the tunnel targets"
}

variable "hostname" {
  type        = string
  description = "Hostname to create dns/tunnel for"
}

variable "zone" {
  type = object({
    id         = string
    zone       = string
    account_id = string
  })
  description = "The cloudflare zone"
}
