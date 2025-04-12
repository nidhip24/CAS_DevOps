output "ui_sg_id" {
  description = "ID of the UI security group"
  value       = aws_security_group.ui_sg.id
}

output "backend_sg_id" {
  description = "ID of the backend security group"
  value       = aws_security_group.backend_sg.id
}

output "db_sg_id" {
  description = "ID of the database security group"
  value       = aws_security_group.db_sg.id
} 