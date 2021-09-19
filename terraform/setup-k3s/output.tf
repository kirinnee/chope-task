output "master" {
  value = {
    private_ip = digitalocean_droplet.master.ipv4_address_private
    public_ip  = digitalocean_droplet.master.ipv4_address
  }
}
output "servers" {
  value = [
    for s in digitalocean_droplet.servers : {
      private_ip = s.ipv4_address_private
      public_ip  = s.ipv4_address
    }
  ]
}

output "agents" {
  value = [
    for s in digitalocean_droplet.agents : {
      private_ip = s.ipv4_address_private
      public_ip  = s.ipv4_address
    }
  ]
}
