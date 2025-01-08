kubectl apply -f /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/k8s/_vmctl/_script/k8s/storage-class/standard.yaml
# Set to default storage class
kubectl patch storageclass nfs-storage -p '{"metadata": {"annotations": {"storageclass.kubernetes.io/is-default-class":"true"}}}'