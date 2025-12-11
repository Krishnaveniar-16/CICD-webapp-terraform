variable "subscription_id" {
  description = "The Azure Subscription ID."
  type        = string
}

variable "client_id" {
  description = "The Azure Service Principal Client ID (appId)."
  type        = string
}

variable "client_secret" {
  description = "The Azure Service Principal Client Secret/Password."
  type        = string
  sensitive   = true 
}

variable "tenant_id" {
  description = "The Azure Active Directory Tenant ID."
  type        = string
}