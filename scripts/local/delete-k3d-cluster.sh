#! /bin/sh

clusterName="gitlab-cluster"
input="$1"
[ "$input" = '' ] && input="$clusterName"

echo "Attempting to delete cluster '$input'..."

# obtain existing cluster
current="$(k3d cluster ls -o json | jq -r --arg input "${input}" '.[] | select(.name == $input) | .name')"
if [  "$current" = "$input" ]; then 
  echo "Cluster found! Deleting cluster..."
  k3d cluster delete "$input"
  exit
fi
echo "Cluster does not exist!"
