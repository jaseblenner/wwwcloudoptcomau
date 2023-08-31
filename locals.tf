locals {
  remote_workspaces = [
    "org-cloudflare-master"
  ]
}

locals {
  dns_zone = data.terraform_remote_state.workspaces["org-cloudflare-master"].outputs.cf_zone_cloudoptcomau
}
