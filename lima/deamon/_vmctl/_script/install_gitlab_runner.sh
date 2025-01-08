#!/bin/zsh
source import_env.sh
# Install gitlab-runner
limactl shell $VM_NAME bash -c '
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm64

# Give it permission to execute
sudo chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
sudo useradd --comment "GitLab Runner" --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start
sudo echo "gitlab-runner ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/gitlab-runner
sudo usermod -aG docker gitlab-runner
'