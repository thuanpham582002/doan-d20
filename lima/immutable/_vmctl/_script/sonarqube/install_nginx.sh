#!/bin/bash

# Update package lists
apt-get update

# Install prerequisites
apt-get install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring

# Import official nginx signing key
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

# Add nginx repository
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

# Update package lists again
apt-get update

# Install nginx
apt-get install -y nginx

# Copy nginx configuration file
cp /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/immutable/resource/sonarqube/nginx.conf /etc/nginx/nginx.conf

# Start nginx service
systemctl start nginx

# Enable nginx to start on boot
systemctl enable nginx

# Verify installation
nginx -v
