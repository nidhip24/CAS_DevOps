# Datadog Monitoring for Kubernetes

This directory contains everything needed to set up Datadog monitoring for your Kubernetes cluster, as described in the [Datadog blog article](https://www.datadoghq.com/blog/monitoring-kubernetes-with-datadog/).

## Prerequisites

1. A Datadog account with API and APP keys
2. A running Kubernetes cluster (your CAS application cluster)

## Setup Steps

### 1. Create the Datadog Secret

First, you need to create a secret containing your Datadog API and APP keys:

```bash
# Make the script executable
chmod +x create-datadog-secret.sh

# Run it with your Datadog API and APP keys
./create-datadog-secret.sh <YOUR_DATADOG_API_KEY> <YOUR_DATADOG_APP_KEY>

# Apply the generated secret
kubectl apply -f datadog-secret.yaml
```

### 2. Deploy kube-state-metrics

Deploy kube-state-metrics to expose additional metrics about your Kubernetes cluster's state:

```bash
kubectl apply -f kube-state-metrics.yaml
```

### 3. Deploy the Datadog Cluster Agent

Deploy the Datadog Cluster Agent:

```bash
kubectl apply -f datadog-cluster-agent.yaml
```

### 4. Deploy the Datadog Node Agent

Deploy the Datadog Node Agent as a DaemonSet:

```bash
kubectl apply -f datadog-agent.yaml
```

### 5. Apply Autodiscovery ConfigMap

Apply the ConfigMap for Datadog's Autodiscovery feature:

```bash
kubectl apply -f datadog-autodiscovery-config.yaml
```

### 6. Add Annotations to Your MySQL Deployment

Add the following annotations to your MySQL deployment to enable Autodiscovery:

```yaml
metadata:
  annotations:
    ad.datadoghq.com/mysql.check_names: '["mysql"]'
    ad.datadoghq.com/mysql.init_configs: '[{}]'
    ad.datadoghq.com/mysql.instances: |
      [
        {
          "host": "%%host%%", 
          "port": 3306,
          "username": "root", 
          "password": "%%env_MYSQL_ROOT_PASSWORD%%"
        }
      ]
    ad.datadoghq.com/mysql.logs: '[{"source":"mysql","service":"mysql"}]'
```

You can do this by editing your existing MySQL deployment:

```bash
kubectl edit deployment mysql
```

### 7. Enable APM for Backend Services

Add these environment variables to your backend application to enable APM:

```yaml
env:
  - name: DATADOG_TRACE_AGENT_HOSTNAME
    valueFrom:
      fieldRef:
        fieldPath: status.hostIP
  - name: DD_SERVICE
    value: "backend"
  - name: DD_ENV
    value: "production"
  - name: DD_LOGS_INJECTION
    value: "true"
```

## Verification

After installing the Datadog Agents, you should start seeing metrics and logs in your Datadog dashboard within a few minutes.

## Features Enabled

This setup includes:

1. Cluster metrics from the Kubernetes API server
2. Node metrics from each worker node
3. Container metrics from Docker
4. kube-state-metrics for higher-level cluster state
5. APM for distributed tracing of applications
6. Log collection from containers
7. Autodiscovery for automatic monitoring of services
8. Network performance monitoring

## Troubleshooting

If you're not seeing data in Datadog:

1. Check that the Datadog Agent pods are running:
   ```bash
   kubectl get pods | grep datadog
   ```

2. Check the logs of the Datadog Agent:
   ```bash
   kubectl logs -l app=datadog-agent -c datadog-agent
   ```

3. Verify the API key is correctly set in the Secret:
   ```bash
   kubectl describe secret datadog-secret
   ``` 