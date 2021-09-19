resource "digitalocean_ssh_key" "default" {
  name       = "K3S Cluster SSH Key"
  public_key = file("./id.pub")
}

resource "digitalocean_droplet" "servers" {
  count = var.server_nodes
  image  = "ubuntu-18-04-x64"
  private_networking = true
  vpc_uuid = digitalocean_vpc.main.id
  name   = "server-${count.index}"
  region = var.region
  size   = var.server_node_type
  ssh_keys = [digitalocean_ssh_key.default.id]
  user_data = file("./cloud-init")
}

resource "digitalocean_droplet" "agents" {
  count = var.agent_nodes
  image  = "ubuntu-18-04-x64"
  name   = "agent-${count.index}"
  vpc_uuid = digitalocean_vpc.main.id
  private_networking = true
  region = var.region
  size   = var.server_node_type
  ssh_keys = [digitalocean_ssh_key.default.id]
  user_data = file("./cloud-init")
}

