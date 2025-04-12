output "ui_alb_dns_name" {
  description = "DNS name of the UI ALB"
  value       = aws_lb.ui_alb.dns_name
}

output "backend_alb_dns_name" {
  description = "DNS name of the backend ALB"
  value       = aws_lb.backend_alb.dns_name
}

output "ui_target_group_arn" {
  description = "ARN of the UI target group"
  value       = aws_lb_target_group.ui.arn
}

output "backend_target_group_arn" {
  description = "ARN of the backend target group"
  value       = aws_lb_target_group.backend.arn
}

output "alb_arn" {
  description = "ARN of the main ALB for WAF association"
  value       = aws_lb.ui_alb.arn
} 