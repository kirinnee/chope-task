resource "digitalocean_ssh_key" "default" {
  name       = "K3S Cluster SSH Key"
  public_key = var.public_key
}

resource "digitalocean_droplet" "master" {
  image              = "ubuntu-18-04-x64"
  private_networking = true
  vpc_uuid           = digitalocean_vpc.main.id
  name               = "master"
  region             = var.region
  size               = var.master_node_type
  ssh_keys           = [digitalocean_ssh_key.default.id]
  #  user_data          = templatefile("${path.module}/cloud-init.tpl", {
  #    k3s_version = var.k3s_version,
  #    k3s_channel = var.k3s_channel,
  #  })
}

resource "digitalocean_droplet" "servers" {
  count              = var.server_nodes
  image              = "ubuntu-18-04-x64"
  private_networking = true
  vpc_uuid           = digitalocean_vpc.main.id
  name               = "server-${count.index}"
  region             = var.region
  size               = var.server_node_type
  ssh_keys           = [digitalocean_ssh_key.default.id]
  #  user_data          = templatefile("${path.module}/cloud-init.tpl", {
  #    k3s_version = var.k3s_version,
  #    k3s_channel = var.k3s_channel,
  #  })
}

resource "digitalocean_droplet" "agents" {
  count              = var.agent_nodes
  image              = "ubuntu-18-04-x64"
  name               = "agent-${count.index}"
  vpc_uuid           = digitalocean_vpc.main.id
  private_networking = true
  region             = var.region
  size               = var.server_node_type
  ssh_keys           = [digitalocean_ssh_key.default.id]
  #  user_data          = templatefile("${path.module}/cloud-init.tpl", {
  #    k3s_version = var.k3s_version,
  #    k3s_channel = var.k3s_channel,
  #  })
}
