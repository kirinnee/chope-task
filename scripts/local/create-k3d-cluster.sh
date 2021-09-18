#! /bin/sh

clusterName="gitlab-cluster"
input="$1"
[ "$input" = '' ] && input="$clusterName"

echo "Attempting to start cluster '$input'..."

# obtain existing cluster
current="$(k3d cluster ls -o json | jq -r --arg input "${input}" '.[] | select(.name == $input) | .name')"
if [  "$current" = "$input" ]; then 
  echo "Cluster already exist!"
  exit
fi
echo "Cluster does not exist, creating..."
k3d cluster create "$input" --config ./k3d-default.yaml
