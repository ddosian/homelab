#!/bin/bash


# Usage:
# ./create-basic-auth.sh -u USERNAME -p PASSWORD -n NAME [-s NAMESPACE] [-o OUTPUT_FILE]

# Examples:
# Output to stdout
# ./create-basic-auth.sh -u admin -p mysecret -n myapp

# Save to file with custom namespace
# ./create-basic-auth.sh -u admin -p mysecret -n myapp -s production -o basic-auth.yaml

# Generated output includes:
# 1. A Secret containing the htpasswd-formatted credentials (apr1 hash)
# 2. A Middleware resource referencing that secret

# To use the middleware in an IngressRoute:
# apiVersion: traefik.io/v1alpha1
# kind: IngressRoute
# metadata:
# name: myapp
# spec:
# routes:
#     - match: Host(`example.com`)
#     middlewares:
#         - name: myapp-basic-auth
#     services:
#         - name: myapp
#         port: 80

set -e

# Default values
NAMESPACE="default"
OUTPUT_FILE=""

usage() {
    echo "Usage: $0 -u USERNAME -p PASSWORD -n NAME [-s NAMESPACE] [-o OUTPUT_FILE]"
    echo ""
    echo "Creates a Traefik BasicAuth middleware YAML with Secret"
    echo ""
    echo "Required:"
    echo "  -u USERNAME    Username for basic auth"
    echo "  -p PASSWORD    Password for basic auth"
    echo "  -n NAME        Name for the middleware and secret"
    echo ""
    echo "Optional:"
    echo "  -s NAMESPACE   Kubernetes namespace (default: default)"
    echo "  -o OUTPUT_FILE Output file path (default: stdout)"
    echo "  -h             Show this help message"
    exit 1
}

# Parse arguments
while getopts "u:p:n:s:o:h" opt; do
    case $opt in
        u) USERNAME="$OPTARG" ;;
        p) PASSWORD="$OPTARG" ;;
        n) NAME="$OPTARG" ;;
        s) NAMESPACE="$OPTARG" ;;
        o) OUTPUT_FILE="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Validate required arguments
if [[ -z "$USERNAME" || -z "$PASSWORD" || -z "$NAME" ]]; then
    echo "Error: Username, password, and name are required"
    usage
fi

# Generate htpasswd string (using openssl for bcrypt-like hash)
# Traefik accepts apr1 (Apache MD5) format
HTPASSWD=$(printf '%s' "$PASSWORD" | openssl passwd -apr1 -stdin)
CREDENTIALS="${USERNAME}:${HTPASSWD}"

# Base64 encode the credentials for the secret
CREDENTIALS_B64=$(echo -n "$CREDENTIALS" | base64)

# Generate the YAML
YAML_CONTENT=$(cat <<EOF
---
apiVersion: v1
kind: Secret
metadata:
  name: ${NAME}-basic-auth
  namespace: ${NAMESPACE}
type: Opaque
data:
  users: ${CREDENTIALS_B64}
---
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: ${NAME}-basic-auth
  namespace: ${NAMESPACE}
spec:
  basicAuth:
    secret: ${NAME}-basic-auth
EOF
)

# Output
if [[ -n "$OUTPUT_FILE" ]]; then
    echo "$YAML_CONTENT" > "$OUTPUT_FILE"
    echo "YAML written to: $OUTPUT_FILE"
else
    echo "$YAML_CONTENT"
fi
