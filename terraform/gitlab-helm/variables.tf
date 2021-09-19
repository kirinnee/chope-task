variable "domain" {
  type        = string
  description = "Base Domain for GitLab"
}

variable "external_ip" {
  type        = string
  description = "External IP for cluster"
}

variable "email" {
  type        = string
  description = "Cert Manager issuer email"
}
