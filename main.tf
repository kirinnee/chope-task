module "setup-k3s" {
  source     = "./terraform/setup-k3s"
  public_key = file("./id.pub")

  region           = var.region
  agent_node_type  = var.agent_node_type
  master_node_type = var.master_node_type
  server_node_type = var.server_node_type

  server_nodes = var.server_nodes
  agent_nodes  = var.agent_nodes
}

module "k3s" {
  source = "./terraform/k3s"

  agent_private_key  = file("~/.ssh/id_rsa")
  server_private_key = file("~/.ssh/id_rsa")

  master = {
    public_ip  = module.setup-k3s.master.public_ip
    private_ip = module.setup-k3s.master.private_ip
    user       = "root"
  }
  agent_count = var.agent_nodes
  agents = [
    for idx in range(var.agent_nodes) : {
      user      = "root"
      public_ip = module.setup-k3s.agents[idx].public_ip
    }
  ]
  server_count = var.server_nodes
  servers = [
    for idx in range(var.server_nodes) : {
      user      = "root"
      public_ip = module.setup-k3s.servers[idx].public_ip
    }
  ]
}

module "gitlab" {
  depends_on  = [module.k3s]
  source      = "./terraform/gitlab-helm"
  domain      = "${module.setup-k3s.master.public_ip}.nip.io"
  external_ip = module.setup-k3s.master.public_ip
  email       = var.email
}
