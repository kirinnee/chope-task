resource "random_password" "k3s_cluster_token" {
  length  = 64
  special = false
}

resource "null_resource" "ca_certificate_install" {
  count = length(local.certificates_files)
  connection {
    type        = "ssh"
    host        = var.master.public_ip
    user        = var.master.user
    private_key = var.server_private_key
  }
  provisioner "remote-exec" {
    inline = [
      <<-EOT
      # --- use sudo if we are not already root ---
      [ $(id -u) -eq 0 ] || exec sudo -n $0 $@
      mkdir -p /var/lib/rancher/k3s/server/tls/
      echo '${local.certificates_files[count.index].file_content}' > /var/lib/rancher/k3s/server/tls/${local.certificates_files[count.index].file_name}
      EOT
    ]
  }
}

resource "null_resource" "master_install" {
  depends_on = [null_resource.ca_certificate_install]
  connection {
    type        = "ssh"
    host        = var.master.public_ip
    user        = var.master.user
    private_key = var.server_private_key
  }


  provisioner "file" {
    source      = "${path.module}/setup-k3s.sh"
    destination = "/tmp/setup-k3s.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /usr/bin/k3s",
      "chmod +x /tmp/setup-k3s.sh",
      "K3S_TOKEN=${random_password.k3s_cluster_token.result} /tmp/setup-k3s.sh master ${var.master.private_ip}"
    ]
  }
}

resource "null_resource" "server_install" {

  depends_on = [null_resource.master_install]

  count = var.server_count

  connection {
    type        = "ssh"
    host        = var.servers[count.index].public_ip
    user        = var.servers[count.index].user
    private_key = var.server_private_key
  }


  provisioner "file" {
    source      = "${path.module}/setup-k3s.sh"
    destination = "/tmp/setup-k3s.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /usr/bin/k3s",
      "chmod +x /tmp/setup-k3s.sh",
      "K3S_TOKEN=${random_password.k3s_cluster_token.result} /tmp/setup-k3s.sh server ${var.master.private_ip}"
    ]
  }
}

resource "null_resource" "agent_install" {

  depends_on = [null_resource.master_install]

  count = var.agent_count

  connection {
    type        = "ssh"
    host        = var.agents[count.index].public_ip
    user        = var.agents[count.index].user
    private_key = var.agent_private_key
  }

  provisioner "file" {
    source      = "${path.module}/setup-k3s.sh"
    destination = "/tmp/setup-k3s.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /usr/bin/k3s",
      "chmod +x /tmp/setup-k3s.sh",
      "K3S_TOKEN=${random_password.k3s_cluster_token.result} /tmp/setup-k3s.sh agent ${var.master.private_ip}"
    ]
  }
}
