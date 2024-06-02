#!/bin/bash

# Function to prompt user for input
prompt() {
    read -p "$1" response
    echo $response
}

# Ask for the repository name
REPO_NAME=$(prompt "Enter the new repository name: ")

# Define server details
SERVER_USER="myuser"
SERVER_ADDRESS="192.168.1.99"
REPO_PATH="/home/pi/repositories"  # Adjust this to an appropriate path on your server

# Create the repository on the remote server
ssh ${SERVER_USER}@${SERVER_ADDRESS} << EOF
    mkdir -p ${REPO_PATH}/${REPO_NAME}
    cd ${REPO_PATH}/${REPO_NAME}
    hg init
EOF

# Clone the repository locally
hg clone ssh://${SERVER_USER}@${SERVER_ADDRESS}/${REPO_PATH}/${REPO_NAME}

echo "Repository ${REPO_NAME} has been created on ${SERVER_ADDRESS} and cloned locally."
