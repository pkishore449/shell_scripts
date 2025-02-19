#!/bin/bash
################################################
#Author: Kishore
#version: v1
#Description: This code is used to get the collabrator names for a github repo
#usage: ./list_github_collabrators.sh <Repo_Owner> <Repo_Name>
##############################################################


# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# User and Repository information
REPO_OWNER=$1
REPO_NAME=$2

# Construct the URL to get collaborators
COLLABORATORS_URL="${API_URL}/repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

# Send GET request to the GitHub API to get collaborators
response=$(curl -s -u "${USERNAME}:${TOKEN}" "$COLLABORATORS_URL")

# Extract users with read (pull) access
collaborators=$(echo "$response" | jq -r '.[] | select(.permissions.pull == true) | .login')

# Display the list of collaborators with read access
if [[ -z "$collaborators" ]]; then
    echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
else
    echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
    echo "$collaborators"
fi
