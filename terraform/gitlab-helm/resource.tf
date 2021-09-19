resource "helm_release" "gitlab" {
  name       = "gitlab"
  repository = "https://charts.gitlab.io"
  chart      = "gitlab"
  version    = "5.2.4"

  values = [
    yamlencode({
      global = {
        edition = "ce"
        ingress = {
          class = ""
        }
        hosts = {
          domain     = var.domain
          externalIP = var.external_ip
        }
        shell = {
          port = 32022
        }

      }
      nginx-ingress = {
        enabled = false
      }
      gitlab = {
        gitlab-shell = {
          service = {
            type     = "NodePort"
            nodePort = 32022
          }
        }
      }

      certmanager-issuer = {
        email = var.email
      }
    })
  ]
}
