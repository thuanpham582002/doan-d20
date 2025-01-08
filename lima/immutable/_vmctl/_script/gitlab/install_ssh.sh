#!/bin/bash

# Define variables
EMAIL="tienthuan05082002@gmail.com"
SSH_DIR="/Users/noroom113/.ssh/gitlab"
KEY_NAME="id_rsa"

# Create the SSH directory if it doesn't exist
mkdir -p "$SSH_DIR"

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f "$SSH_DIR/$KEY_NAME" -N ""

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add the private key to the SSH agent
ssh-add "$SSH_DIR/$KEY_NAME"

# Output the public key for GitLab
echo "Public key (copy this to GitLab):"
cat "$SSH_DIR/$KEY_NAME.pub"