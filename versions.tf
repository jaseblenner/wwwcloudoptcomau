terraform {
  required_version = ">= 1.4.6"
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.42.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">=3.33.1"
    }
  }
}
