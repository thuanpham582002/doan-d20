sudo gitlab-runner register \
  --url http://gitlab.orb.local/ \
  --registration-token GR1348941Txo8iB6z2nxpf8GNauGU \
  --executor docker \
  --docker-image "docker:24.0.5" \
  --docker-privileged \
  --description "docker-runner" \
  --tag-list "docker" \
  --run-untagged="true" \
  --docker-network-mode "host" \
  --docker-pull-policy="if-not-present" \
  --docker-volumes "/var/run/docker.sock:/var/run/docker.sock"

#   --docker-extra-hosts "gitlab.noroom113.com:192.168.105.20" \
#   --docker-extra-hosts "sonarqube.noroom113.com:192.168.105.23" \
