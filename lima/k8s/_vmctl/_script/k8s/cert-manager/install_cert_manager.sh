helm repo add jetstack https://charts.jetstack.io --force-update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.16.1 \
  --set crds.enabled=true

# Install CA
kubectl apply -f /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/k8s/_vmctl/_script/k8s/cert-manager/cert-manager.yaml
