helm repo add argo https://argoproj.github.io/argo-helm

#curl -o values.yaml https://raw.githubusercontent.com/thuanpham582002/Do_An_Resource/refs/heads/main/k8s/argocd/values.yaml

helm delete argocd -n argocd
helm install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace \
  -f /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/k8s/_vmctl/_script/k8s/argocd/values.yaml
#  -f values.yaml

# cleanup
#rm -f values.yaml


#Upgrade
#helm upgrade argocd argo/argo-cd \
#  --namespace argocd \
#  -f /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/k8s/_vmctl/_script/k8s/argocd/values.yaml



## Xoá tất cả các ClusterRole có tên bắt đầu với 'argocd'
#kubectl get clusterrole | awk '/^argocd/ {print $1}' | while read -r role; do
#  kubectl delete clusterrole "$role"
#done
#
## Xoá tất cả các ClusterRoleBinding có tên bắt đầu với 'argocd'
#kubectl get clusterrolebinding | awk '/^argocd/ {print $1}' | while read -r binding; do
#  kubectl delete clusterrolebinding "$binding"
#done
#
#echo "Hoàn tất xóa tất cả các ClusterRole và ClusterRoleBinding bắt đầu bằng 'argocd'."