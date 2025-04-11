# AWS Infrastructure as Code (Terraform)

This repository contains Terraform code to deploy a complete AWS infrastructure as shown in the architecture diagram.

## Architecture Overview

The infrastructure includes:

- **VPC**: A Virtual Private Cloud with multiple Availability Zones
- **Security Groups**: Separate security groups for UI, Backend, and Database tiers
- **Load Balancers**: Application Load Balancers for UI and Backend services
- **Auto Scaling Groups**: Auto Scaling for both UI and Backend services
- **RDS Database**: A highly available MySQL database
- **WAF**: Web Application Firewall for the UI load balancer

## Module Structure

- `vpc`: Network infrastructure including VPC, subnets, NAT gateways and routing
- `security_groups`: Security groups for the different tiers
- `load_balancers`: Application Load Balancers for UI and Backend
- `auto_scaling`: Auto Scaling Groups for UI and Backend EC2 instances
- `rds`: RDS database instance and related resources
- `waf`: Web Application Firewall for the UI load balancer

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (version 1.0+ recommended)

## How to Use

1. Initialize the Terraform workspace:
   ```
   terraform init
   ```

2. Create a `terraform.tfvars` file with your specific values:
   ```
   aws_region      = "us-east-1"
   db_username     = "admin"
   db_password     = "your-secure-password"
   ```

3. Review the planned changes:
   ```
   terraform plan
   ```

4. Apply the changes:
   ```
   terraform apply
   ```

5. When finished, destroy the resources:
   ```
   terraform destroy
   ```

## Security Considerations

- Database credentials are marked as sensitive in Terraform variables
- All security groups follow the principle of least privilege
- WAF is configured to protect against common attacks
- Database is deployed in a private subnet with no direct public access
- All data at rest is encrypted

## Maintenance and Operations

- CloudWatch alarms are set up for both Auto Scaling groups and RDS
- Auto Scaling policies will automatically adjust capacity based on load
- RDS is configured with backups and multi-AZ deployment for high availability 