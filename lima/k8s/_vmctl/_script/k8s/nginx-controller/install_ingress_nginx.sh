helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
echo "Installing nginx-ingress"
# Check nginx-ingress has been installed or not
#!/bin/bash

# Check if nginx-ingress is already installed
if helm status nginx-ingress &>/dev/null; then
  echo "nginx-ingress has been installed"
  echo "Try to re-install nginx-ingress"
  helm delete nginx-ingress
  helm install nginx-ingress ingress-nginx/ingress-nginx -f /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/k8s/_vmctl/_script/k8s/nginx-controller/values.yaml
  exit 0
else
  echo "nginx-ingress not found, installing..."
  helm install nginx-ingress ingress-nginx/ingress-nginx -f /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/k8s/_vmctl/_script/k8s/nginx-controller/values.yaml
fi