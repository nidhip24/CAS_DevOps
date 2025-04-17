#!/bin/bash

# Check if both API key and APP key are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <DATADOG_API_KEY> <DATADOG_APP_KEY>"
    exit 1
fi

DATADOG_API_KEY=$1
DATADOG_APP_KEY=$2

# Encode the keys in base64
API_KEY_BASE64=$(echo -n $DATADOG_API_KEY | base64)
APP_KEY_BASE64=$(echo -n $DATADOG_APP_KEY | base64)

# Create the secret YAML file
cat > datadog-secret.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  name: datadog-secret
  namespace: default
type: Opaque
data:
  api-key: ${API_KEY_BASE64}
  app-key: ${APP_KEY_BASE64}
EOF

echo "Secret YAML file created at datadog-secret.yaml"
echo "You can apply it with: kubectl apply -f datadog-secret.yaml" 