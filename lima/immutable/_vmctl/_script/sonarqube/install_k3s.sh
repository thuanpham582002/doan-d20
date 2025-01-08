#!/bin/sh
if [ ! -d /var/lib/rancher/k3s ]; then
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644" sh -
fi  