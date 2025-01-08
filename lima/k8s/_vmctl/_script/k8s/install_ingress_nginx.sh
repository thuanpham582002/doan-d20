helm install ingress-nginx ingress-nginx/ingress-nginx \
  --set controller.service.type=NodePort \
  --set controller.service.nodePorts.http="30113" \
  --set controller.service.nodePorts.https="30114"