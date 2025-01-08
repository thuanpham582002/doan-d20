#!/bin/bash
set -eux -o pipefail
# Initializing your control-plane node
kubeadm="""
apiVersion: kubeadm.k8s.io/v1beta3
kind: JoinConfiguration
discovery:
  bootstrapToken:
    apiServerEndpoint: 192.168.105.51:6443
    token: 9a08jv.c0izixklcxtmnze7
    unsafeSkipCAVerification: true
nodeRegistration:
  name: \"${WORKER_NAME}\"
  kubeletExtraArgs:
    node-ip: ${WORKER_IP}
"""

echo "$kubeadm" | sudo tee control-plane-join-cfg.yaml

sudo kubeadm join --config control-plane-join-cfg.yaml

