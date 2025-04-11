output "ui_asg_name" {
  description = "Name of the UI auto scaling group"
  value       = aws_autoscaling_group.ui.name
}

output "backend_asg_name" {
  description = "Name of the backend auto scaling group"
  value       = aws_autoscaling_group.backend.name
}

output "ui_launch_template_id" {
  description = "ID of the UI launch template"
  value       = aws_launch_template.ui.id
}

output "backend_launch_template_id" {
  description = "ID of the backend launch template"
  value       = aws_launch_template.backend.id
} 