#! /bin/bash
deploymentName="gitlab"
input="$1"
[ "$input" = '' ] && input="$deploymentName"

helm repo add gitlab https://charts.gitlab.io/
helm upgrade --install "$deploymentName" gitlab/gitlab --timeout 600s -f ./local.yaml
echo "Successfully installed GitLab CE"
