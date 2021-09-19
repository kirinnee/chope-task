module "k3s" {
  source         = "xunleii/k3s/module"
  k3s_version    = "v1.22.2"
  cidr           = {
    pods     = "10.0.0.0/16"
    services = "10.1.0.0/16"
  }

  drain_timeout  = "30s"
  managed_fields = ["label", "taint"]
  global_flags   = [
    "--tls-san k3s.my.domain.com"
  ]
  servers        = {
    for idx in range(var.server_nodes) :
    "server-${idx}" => {
      ip         = digitalocean_droplet.servers[idx].ipv4_address_private // internal node IP
      connection = {
        host = digitalocean_droplet.servers[idx].ipv4_address
        user = "root"
        private_key = file("~/.ssh/id_rsa")
      }
      flags      = ["--flannel-backend=none"]
      labels     = { "node.kubernetes.io/type" = "master" }
    }

  }

  agents = {
    for idx in range(var.agent_nodes) :
    "agent-${idx}" => {
      ip         = digitalocean_droplet.agents[idx].ipv4_address_private
      connection = {
        user         = "root"
        bastion_host = digitalocean_droplet.servers[0].ipv4_address
        bastion_user = "root"
        bastion_private_key  = file("~/.ssh/id_rsa")
        private_key = file("~/.ssh/id_rsa")
      }
      labels     = { "node.kubernetes.io/pool" = "service-pool" }
    }
  }

}



