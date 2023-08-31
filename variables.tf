variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token"
  sensitive   = true
  default     = null
}

variable "cloudflare_master_account_id" {
  type        = string
  description = "id of cloudflare master account"
  sensitive   = false
  default     = null
}

variable "tfc_org" {
  type        = string
  description = "terraform cloud organization name"
  default     = null
}

variable "environment" {
  type        = string
  description = "environment we are working from"
  default     = null
}

variable "project_name" {
  type        = string
  description = "name of our project"
  default     = "wwwcloudoptcomau"
}
