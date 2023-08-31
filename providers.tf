provider "tfe" {
  token = var.tfc_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
