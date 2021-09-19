resource "digitalocean_vpc" "main" {
  name     = "k3s-cluster-vpc"
  region   = var.region
  ip_range = "10.10.0.0/16"
}