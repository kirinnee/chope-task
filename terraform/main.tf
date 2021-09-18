resource "digitalocean_droplet" "servers" {
  count = 1
  image  = "ubuntu-18-04-x64"
  private_network = true
  name   = "server-${count.index}"
  region = "sgp1"
  size   = "s-4vcpu-8gb"
}

resource "digitalocean_droplet" "agents" {
  count = 3
  image  = "ubuntu-18-04-x64"
  name   = "agent-${count.index}"
  private_network = true
  region = "sgp1"
  size   = "s-4vcpu-8gb"
}

module "k3s" {
  source  = "xunleii/k3s/module"
  k3s_version = "v1.0.0"
  name = "my.k3s.local"
  cidr = {
    pods = "10.0.0.0/16"
    services = "10.1.0.0/16"
  }
  drain_timeout = "30s"
  managed_fields = ["label", "taint"]
  /* global_flags = [
    "--tls-san k3s.my.domain.com"
  ] */
  servers = {

    server-one = {
      ip = "10.123.45.67" // internal node IP
      connection = {
        host = "203.123.45.67" // public node IP
        user = "ubuntu"
      }
      flags = ["--flannel-backend=none"]
      labels = {"node.kubernetes.io/type" = "master"}
      taints = {"node.k3s.io/type" = "server:NoSchedule"}
    }
    server-two = {
      ip = "10.123.45.68"
      connection = {
        host = "203.123.45.68" // bastion node
        user = "ubuntu"
      }
      flags = ["--flannel-backend=none"]
      labels = {"node.kubernetes.io/type" = "master"}
      taints = {"node.k3s.io/type" = "server:NoSchedule"}
    }
    server-three = {
      ip = "10.123.45.69"
      connection = {
        host = "203.123.45.69" // bastion node
        user = "ubuntu"
      }
      flags = ["--flannel-backend=none"]
      labels = {"node.kubernetes.io/type" = "master"}
      taints = {"node.k3s.io/type" = "server:NoSchedule"}
    }
  }
  agents = {
      agent-one = {
          ip = "10.123.45.70"
          connection = {
              user = "root"
              bastion_host = "203.123.45.67" // server_one node used as bastion
              bastion_user = "ubuntu"
          }
          labels = {"node.kubernetes.io/pool" = "service-pool"}
      },
      agent-two = {
          ip = "10.123.45.71"
          connection = {
              user = "root"
              bastion_host = "203.123.45.67"
              bastion_user = "ubuntu"
          }
          labels = {"node.kubernetes.io/pool" = "service-pool"}
      },
      agent-three = {
          name = "gpu-agent-one"
          ip = "10.123.45.72"
          connection = {
              user = "root"
              bastion_host = "203.123.45.67"
              bastion_user = "ubuntu"
          }
          labels = {"node.kubernetes.io/pool" = "gpu-pool"}
          taints = {dedicated = "gpu:NoSchedule"}
      },
  }
}



