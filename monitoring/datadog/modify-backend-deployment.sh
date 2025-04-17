#!/bin/bash

# Path to your backend deployment file
BACKEND_DEPLOYMENT_FILE="/home/project/CAS_DevOps/k8s/backend-deployment.yaml"

# Check if the file exists
if [ ! -f "$BACKEND_DEPLOYMENT_FILE" ]; then
    echo "Error: Backend deployment file not found at $BACKEND_DEPLOYMENT_FILE"
    exit 1
fi

# Create a backup of the original file
cp "$BACKEND_DEPLOYMENT_FILE" "${BACKEND_DEPLOYMENT_FILE}.bak"
echo "Created backup at ${BACKEND_DEPLOYMENT_FILE}.bak"

# Find the line number of the last environment variable
LAST_ENV_LINE=$(grep -n "env:" "$BACKEND_DEPLOYMENT_FILE" | tail -1 | cut -d: -f1)
LAST_ENV_LINE=$((LAST_ENV_LINE + 2))  # Move to the last line of env section

# Add Datadog APM environment variables to the backend deployment
awk -v last_env_line="$LAST_ENV_LINE" '
NR == last_env_line {
    print $0;
    print "            - name: DATADOG_TRACE_AGENT_HOSTNAME";
    print "              valueFrom:";
    print "                fieldRef:";
    print "                  fieldPath: status.hostIP";
    print "            - name: DD_SERVICE";
    print "              value: \"backend\"";
    print "            - name: DD_ENV";
    print "              value: \"production\"";
    print "            - name: DD_LOGS_INJECTION";
    print "              value: \"true\"";
    next;
}
{ print $0; }
' "$BACKEND_DEPLOYMENT_FILE" > "${BACKEND_DEPLOYMENT_FILE}.new"

# Replace the original file
mv "${BACKEND_DEPLOYMENT_FILE}.new" "$BACKEND_DEPLOYMENT_FILE"

echo "Added Datadog APM environment variables to backend deployment"
echo "You can apply the changes with: kubectl apply -f $BACKEND_DEPLOYMENT_FILE" 