#!/bin/bash

# Get the namespace name from the first command-line argument
NAMESPACE_NAME="$1"

# Check if a namespace name was provided
if [[ -z "$NAMESPACE_NAME" ]]; then
  echo "Usage: $0 <namespace_name>"
  exit 1
fi

# Check if the namespace exists
kubectl get namespace "$NAMESPACE_NAME" > /dev/null 2>&1

# Check the return code of the kubectl command
if [[ $? -ne 0 ]]; then
  # Namespace does not exist, create it
  echo "Namespace '$NAMESPACE_NAME' does not exist. Creating..."
  kubectl create namespace "$NAMESPACE_NAME"
  if [[ $? -eq 0 ]]; then
    echo "Namespace '$NAMESPACE_NAME' created successfully."
  else
    echo "Error creating namespace '$NAMESPACE_NAME'."
    exit 1  # Exit with an error code
  fi
else
  # Namespace exists
  echo "Namespace '$NAMESPACE_NAME' already exists."
fi

exit 0 # Exit with success code