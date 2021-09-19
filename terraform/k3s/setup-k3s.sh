#!/bin/sh

type="$1"
masterIp="$2"

check=k3s kubectl get nodes

if [ "$type" = "master" ]; then
	echo "Initializing Master Node..."
	curl -sfL https://get.k3s.io | sh -s - server --cluster-init
	echo "Master node initialized"
elif [ "$type" = "server" ]; then
	echo "Initializing Server Node..."
	curl -sfL https://get.k3s.io | sh -s - server --server "https://${masterIp}:6443"
	echo "Server node initialized"
else
	echo "Initializing Agent Node..."
	curl -sfL https://get.k3s.io | sh -s - agent --server "https://${masterIp}:6443"
	check=systemctl is-active --quiet k3s-agent.service
	echo "Agent node initialized"
fi

echo "Waiting for server to be up..."

# shellcheck disable=SC2154
until $check; do
	echo "Waiting for server to be up..."
	sleep 1s
done

echo "Setup successfully completed"
