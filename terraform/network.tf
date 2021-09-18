resource "digitalocean_vpc" "main_vpc" {
  name     = "example-project-network"
  region   = "nyc3"
  ip_range = "10.10.0.0/16"
}