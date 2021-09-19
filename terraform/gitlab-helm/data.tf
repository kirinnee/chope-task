data "kubernetes_secret" "initial_root_password" {
  metadata {
    name      = "gitlab-gitlab-initial-root-password"
    namespace = "default"
  }
}

output "initial_secret" {
  value     = data.kubernetes_secret.initial_root_password.data
  sensitive = true
}
