# Application Load Balancer for UI/frontend
resource "aws_lb" "ui_alb" {
  name               = "ui-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ui_sg_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "ui-alb"
  }
}

resource "aws_lb_target_group" "ui" {
  name     = "ui-target-group"
  port     = 30080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  
  health_check {
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 30
    interval            = 300
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "ui_http" {
  load_balancer_arn = aws_lb.ui_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ui.arn
  }
}

# Optional HTTPS listener
resource "aws_lb_listener" "ui_https" {
  count             = var.certificate_arn != null ? 1 : 0
  load_balancer_arn = aws_lb.ui_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ui.arn
  }
}

# Internal Application Load Balancer for Backend
resource "aws_lb" "backend_alb" {
  name               = "backend-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.backend_sg_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "backend-alb"
  }
}

resource "aws_lb_target_group" "backend" {
  name     = "backend-target-group"
  port     = 30081
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  
  health_check {
    path                = "/health"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 30
    interval            = 300
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
} 