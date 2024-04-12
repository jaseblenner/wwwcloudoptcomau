# Create Cloudflare Pages project
resource "cloudflare_pages_project" "cloudopt" {
  account_id        = var.cloudflare_master_account_id
  name              = var.project_name
  production_branch = "main"

  source {
    type = "github"
    config {
      owner                         = "jaseblenner"
      repo_name                     = "wwwcloudoptcomau" # ensure the cloudflare github app has access to the repo
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_deployment_setting    = "custom"
      preview_branch_includes       = ["main", "dev*"]
    }
  }

  build_config {
    build_command   = "npm run build"
    destination_dir = "dist"
    root_dir        = "app"
  }

  deployment_configs {
    preview {
      environment_variables = {
        NODE_VERSION = "17"
      }
    }
    production {
      environment_variables = {
        NODE_VERSION = "17"
      }
    }
  }
}

## Associate our Cloudflare Pages Project with a domain
resource "cloudflare_pages_domain" "cloudopt" {
  account_id   = var.cloudflare_master_account_id
  project_name = var.project_name
  domain       = local.dns_zone.zone
}

## Point our root domain at the cloudflare pages CNAME
resource "cloudflare_record" "cloudopt" {
  zone_id = local.dns_zone.id
  name    = "@"
  value   = cloudflare_pages_project.cloudopt.subdomain
  type    = "CNAME"
  ttl     = 60
}

## Redirect www to our domain apex
## Ref: https://developers.cloudflare.com/pages/how-to/www-redirect/
resource "cloudflare_record" "wwwcloudopt" {
  zone_id = local.dns_zone.id
  name    = "www"
  value   = "192.0.2.1"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_ruleset" "wwwcloudopt" {
  zone_id = local.dns_zone.id
  name    = "www_redirect_to_https"
  kind    = "zone"
  phase   = "http_request_dynamic_redirect"

  rules {
    action = "redirect"
    action_parameters {
      from_value {
        status_code = 301
        target_url {
          value = "https://${cloudflare_record.cloudopt.hostname}"
        }
        preserve_query_string = true
      }
    }
    expression  = "(http.host eq \"${cloudflare_record.wwwcloudopt.hostname}\")"
    description = "Redirect ${cloudflare_record.wwwcloudopt.hostname} to https://${cloudflare_record.cloudopt.hostname}"
    enabled     = true
  }
}
