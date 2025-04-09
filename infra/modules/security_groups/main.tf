# UI Security Group - for the UI/frontend instances and load balancer
resource "aws_security_group" "ui_sg" {
  name        = "ui-security-group"
  description = "Security group for UI instances and load balancer"
  vpc_id      = var.vpc_id

  # Allow HTTP and HTTPS from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic"
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "ui-security-group"
  }
}

# Backend Security Group - for the backend instances and load balancer
resource "aws_security_group" "backend_sg" {
  name        = "backend-security-group"
  description = "Security group for backend instances and load balancer"
  vpc_id      = var.vpc_id

  # Allow traffic from UI security group
  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.ui_sg.id]
    description     = "Allow API traffic from UI"
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "backend-security-group"
  }
}

# Database Security Group - for RDS
resource "aws_security_group" "db_sg" {
  name        = "db-security-group"
  description = "Security group for database"
  vpc_id      = var.vpc_id

  # Allow traffic from backend security group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
    description     = "Allow MySQL/Aurora traffic from backend"
  }

  # No direct outbound access needed for the database
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "db-security-group"
  }
} 