resource "digitalocean_droplet" "servers" {
  count = 1
  image  = "ubuntu-18-04-x64"
  private_network = true
  vpc_uuid = digitalocean_vpc.main_vpc.id
  name   = "server-${count.index}"
  region = "sgp1"
  size   = "s-4vcpu-8gb"
}

resource "digitalocean_droplet" "agents" {
  count = 3
  image  = "ubuntu-18-04-x64"
  name   = "agent-${count.index}"
  vpc_uuid = digitalocean_vpc.main_vpc.id
  private_network = true
  region = "sgp1"
  size   = "s-4vcpu-8gb"
}
