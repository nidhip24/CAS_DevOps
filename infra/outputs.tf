output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "ui_alb_dns_name" {
  description = "DNS name of the UI ALB"
  value       = module.load_balancers.ui_alb_dns_name
}

output "backend_alb_dns_name" {
  description = "DNS name of the backend ALB"
  value       = module.load_balancers.backend_alb_dns_name
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.db_instance_endpoint
}

output "waf_web_acl_id" {
  description = "ID of the WAF Web ACL"
  value       = module.waf.web_acl_id
}

output "ui_asg_name" {
  description = "Name of the UI Auto Scaling Group"
  value       = module.auto_scaling.ui_asg_name
}

output "backend_asg_name" {
  description = "Name of the Backend Auto Scaling Group"
  value       = module.auto_scaling.backend_asg_name
} 