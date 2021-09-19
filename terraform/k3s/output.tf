output "kubernetes" {
  description = "Authentication credentials of Kubernetes (full administrator)."
  value = {
    cluster_ca_certificate = local.cluster_ca_certificate
    client_certificate     = local.client_certificate
    client_key             = local.client_key
    api_endpoint           = "https://${var.master.public_ip}:6443"
  }
  sensitive = true
}
