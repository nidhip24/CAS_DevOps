# Create DB subnet group
resource "aws_db_subnet_group" "main" {
  name        = "main-db-subnet-group"
  description = "Database subnet group"
  subnet_ids  = var.database_subnet_ids

  tags = {
    Name = "main-db-subnet-group"
  }
}

# Create RDS instance
resource "aws_db_instance" "main" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.db_sg_id]
  skip_final_snapshot    = true
  multi_az               = false
  backup_retention_period = 7
  
  # Prevent auto minor version upgrade
  auto_minor_version_upgrade = false
  
  # Enable encryption
  storage_encrypted = true
  
  # Enable CloudWatch logs export
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
  
  tags = {
    Name = "main-db-instance"
  }
}

# Enhanced monitoring
resource "aws_cloudwatch_metric_alarm" "database_cpu" {
  alarm_name          = "database-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Database CPU utilization is too high"

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}

resource "aws_cloudwatch_metric_alarm" "database_memory" {
  alarm_name          = "database-low-memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 120
  statistic           = "Average"
  threshold           = 100000000  # 100MB in bytes
  alarm_description   = "Database freeable memory is too low"

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
}

resource "aws_cloudwatch_metric_alarm" "database_storage" {
  alarm_name          = "database-low-storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = 120
  statistic           = "Average"
  threshold           = 2000000000  # 2GB in bytes
  alarm_description   = "Database free storage space is too low"

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.main.id
  }
} 