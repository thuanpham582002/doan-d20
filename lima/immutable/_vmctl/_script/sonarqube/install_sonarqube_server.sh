# Configure kubectl to use k3s config
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

kubectl create secret generic cacerts \
  --from-file=rootCA.crt=/Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/certificate_crt/rootCA.crt \
  -n sonarqube

helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update
kubectl create namespace sonarqube
helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube -f /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/immutable/_vmctl/_script/sonarqube/values.yaml