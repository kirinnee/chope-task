locals {
  host                   = module.k3s.kubernetes.api_endpoint
  client_certificate     = module.k3s.kubernetes.client_certificate
  client_key             = module.k3s.kubernetes.client_key
  cluster_ca_certificate = module.k3s.kubernetes.cluster_ca_certificate

}

provider "helm" {
  kubernetes {
    host                   = local.host
    client_certificate     = local.client_certificate
    cluster_ca_certificate = local.cluster_ca_certificate
    client_key             = local.client_key
  }
}

provider "kubernetes" {
  host = local.host

  client_certificate     = local.client_certificate
  cluster_ca_certificate = local.cluster_ca_certificate
  client_key             = local.client_key
}
