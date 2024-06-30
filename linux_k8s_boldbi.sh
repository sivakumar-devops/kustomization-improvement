#!/bin/bash

# Usage: sudo ./apply_kustomization.sh --url http://example.com --path /path/to/replace

# Function to show usage
usage() {
    echo "Usage: $0 --url <AppBase-URL> --path <Example/path/here>"
    exit 1
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --url) APP_BASE_URL="$2"; shift ;;
        --path) EXAMPLE_PATH="$2"; shift ;;
        *) usage ;;
    esac
    shift
done

# Check if both arguments are provided
if [ -z "$APP_BASE_URL" ] || [ -z "$EXAMPLE_PATH" ]; then
    usage
fi

# Download the file
curl -o kustomization.yaml https://raw.githubusercontent.com/sivakumar-devops/kustomization-improvement/mohamed/local/boldbi/kustomization.yaml

# Modify the file
sed -i "s|<AppBase-URL>|$APP_BASE_URL|g" kustomization.yaml
sed -i "s|<Example/path/here>|$EXAMPLE_PATH|g" kustomization.yaml

# Apply the kustomization
kubectl apply -k .

echo "Kustomization applied successfully."
