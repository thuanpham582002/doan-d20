if command -v gitlab-runner &> /dev/null; then
    echo "GitLab Runner is already installed"
else
    sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-arm64
    # Give it permission to execute
    sudo chmod +x /usr/local/bin/gitlab-runner

    # Check if gitlab-runner user exists
    if ! id "gitlab-runner" &>/dev/null; then
        # Create a GitLab Runner user
        sudo useradd --comment "GitLab Runner" --create-home gitlab-runner --shell /bin/bash
    fi

    # Install and run as a service
    sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
fi


sudo gitlab-runner start
sudo echo "gitlab-runner ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/gitlab-runner
sudo usermod -aG docker gitlab-runner