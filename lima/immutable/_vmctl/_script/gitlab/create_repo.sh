#!/bin/zsh

# Variables
GITLAB_TOKEN="your_gitlab_token"
GITLAB_DOMAIN="gitlab.noroom113.com"
GROUP_NAME="ecommerce_k8s"
BACKEND_REPO="backend"
FRONTEND_REPO="frontend"

# Function to create a group
create_group() {
  curl -k -X POST "https://$GITLAB_DOMAIN/api/v4/groups" \
       -H "Authorization: Bearer $GITLAB_TOKEN" \
       -H "Content-Type: application/json" \
       -d "{\"name\": \"$GROUP_NAME\", \"path\": \"$GROUP_NAME\"}"
}

# Function to get the group ID by name
get_group_id() {
  curl -k -s -X GET "https://$GITLAB_DOMAIN/api/v4/groups?search=$GROUP_NAME" \
       -H "Authorization: Bearer $GITLAB_TOKEN" | jq -r '.[0].id'
}

# Function to create a repository within the group
create_repo() {
  local repo_name=$1
  local group_id=$2
  curl -k -X POST "https://$GITLAB_DOMAIN/api/v4/projects" \
       -H "Authorization: Bearer $GITLAB_TOKEN" \
       -H "Content-Type: application/json" \
       -d "{\"name\": \"$repo_name\", \"namespace_id\": \"$group_id\"}"
}

# Main script execution
create_group
GROUP_ID=$(get_group_id)

# Check if group creation was successful
if [[ -z "$GROUP_ID" || "$GROUP_ID" == "null" ]]; then
  echo "Failed to create or retrieve the group ID."
  exit 1
fi

# Create repositories
create_repo "$BACKEND_REPO" "$GROUP_ID"
create_repo "$FRONTEND_REPO" "$GROUP_ID"

echo "Group and repositories created successfully."