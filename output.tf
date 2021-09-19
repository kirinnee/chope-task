output "gitlab_address" {
  value = "https://gitlab.${module.setup-k3s.master.public_ip}.nip.io"
}

output "initial_secret" {
  value     = module.gitlab.initial_secret
  sensitive = true
}
