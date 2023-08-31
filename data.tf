data "terraform_remote_state" "workspaces" {
  for_each = toset(local.remote_workspaces)
  backend  = "remote"

  config = {
    organization = var.tfc_org
    workspaces = {
      name = each.value
    }
  }
}

data "cloudflare_zones" "zones" {
  filter {
    account_id = var.cloudflare_master_account_id
    status     = "active"
  }
}
