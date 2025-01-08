#!/bin/bash
set -eux -o pipefail
# Initializing your control-plane node
kubeadm="""
kind: InitConfiguration
apiVersion: kubeadm.k8s.io/v1beta3
bootstrapTokens:
- token: \"9a08jv.c0izixklcxtmnze7\"
  description: \"Initial bootstrap token for the first time setup of a kubernetes cluster\"
  ttl: \"1h\"
certificateKey: \"c411505d8504115b928286cc37a83c230d80c4db06bdf19d8f64828e3724d363\"
localAPIEndpoint:
  advertiseAddress: "${CONTROL_PLANE_IP}"
  bindPort: 6443
nodeRegistration:
  name: \"${CONTROL_PLANE_NAME}\"
---
kind: ClusterConfiguration
apiVersion: kubeadm.k8s.io/v1beta3
networking:
  podSubnet: \"10.244.0.0/16\"
"""

echo "$kubeadm" | sudo tee kubeadm-config.yaml
sudo kubeadm init --upload-certs --config kubeadm-config.yaml
# Installing a Pod network add-on
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Control plane node isolation
kubectl taint nodes --all node-role.kubernetes.io/control-plane-