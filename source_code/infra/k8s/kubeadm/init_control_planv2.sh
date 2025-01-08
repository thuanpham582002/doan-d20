#!/bin/bash
set -eux -o pipefail
test -e /etc/kubernetes/admin.conf && exit 0
#export KUBECONFIG=/etc/kubernetes/admin.conf
#kubeadm config images list
#kubeadm config images pull --cri-socket=unix:///run/containerd/containerd.sock
#nodeRegistration:
#  criSocket: unix:///run/containerd/containerd.sock

# Initializing your control-plane node
kubeadm="""
kind: InitConfiguration
apiVersion: kubeadm.k8s.io/v1beta3
localAPIEndpoint:
  advertiseAddress: "${CONTROL_PLANE_IP}"
  bindPort: 6443
---
kind: ClusterConfiguration
apiVersion: kubeadm.k8s.io/v1beta3
apiServer:
  certSANs: # --apiserver-cert-extra-sans
  - \"127.0.0.1\"
controlPlaneEndpoint: \"${CONTROL_PLANE_IP}:6443\"
networking:
  podSubnet: \"10.244.0.0/16\" # --pod-network-cidr
---
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
cgroupDriver: systemd
"""

echo "$kubeadm" | sudo tee kubeadm-config.yaml

kubeadm init --config kubeadm-config.yaml
# Installing a Pod network add-on
kubectl apply -f https://github.com/flannel-io/flannel/releases/download/v0.24.0/kube-flannel.yml
# Control plane node isolation
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
## Replace the server address with localhost, so that it works also from the host
#sed -e "/server:/ s|https://.*:\([0-9]*\)$|https://127.0.0.1:\1|" -i $KUBECONFIG
#mkdir -p ${HOME:-/root}/.kube && cp -f $KUBECONFIG ${HOME:-/root}/.kube/config

sudo kubeadm init --config kubeadm-config.yaml
# if you want to use kubectl as a regular user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://github.com/flannel-io/flannel/releases/download/v0.24.0/kube-flannel.yml

#    set -eux -o pipefail
#    export KUBECONFIG=/etc/kubernetes/admin.conf
#    mkdir -p {{.Home}}/.kube
#    cp -f $KUBECONFIG {{.Home}}/.kube/config
#    chown -R {{.User}} {{.Home}}/.kube
