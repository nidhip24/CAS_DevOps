# Get latest Ubuntu Server 24 AMI
data "aws_ami" "ubuntu_24" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical's owner ID for Ubuntu

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# UI/Frontend Launch Template
resource "aws_launch_template" "ui" {
  name_prefix   = "ui-"
  image_id      = data.aws_ami.ubuntu_24.id
  instance_type = var.ui_instance_type
  key_name      = "demo-ec2"
  iam_instance_profile {
    name = "DemoEC2"  # Attach the IAM role
  }
  
  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get install -y ansible git python3-pip python3-venv sshpass unzip
    export ANSIBLE_HOST_KEY_CHECKING=False
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    curl -fsSL https://tailscale.com/install.sh | sh
    TS_AUTHKEY=$(aws ssm get-parameter --name "/tailscale/auth-key" --with-decryption --query Parameter.Value --output text --region us-east-1)

    sudo tailscale up --authkey=$TS_AUTHKEY

    python3 -m venv /home/ubuntu/myenv
    source /home/ubuntu/myenv/bin/activate
    pip install boto3 botocore

    VAULT_PASS=$(aws ssm get-parameter --name "/ansible/vault-pass" --with-decryption --query Parameter.Value --output text --region us-east-1)
    echo "$VAULT_PASS" > /home/ubuntu/.vault_pass.txt
    chmod 600 /home/ubuntu/.vault_pass.txt

    git clone https://github.com/nidhip24/CAS_DevOps /home/ubuntu/CAS_DevOps
    cd /home/ubuntu/CAS_DevOps/infra_setup/
    ansible-playbook k8s_docker_setup.yml
    ansible-playbook -i inventory.ini k8s_worker.yml  --vault-password-file /home/ubuntu/.vault_pass.txt
  EOF
    # ansible-playbook k8s_docker_setup.yml
    # ansible-playbook k8s_cluster_init.yml
  )
  
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.ui_sg_id]
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ui-instance"
      Role = "ui-worker"
    }
  }
}

# Backend Launch Template
resource "aws_launch_template" "backend" {
  name_prefix   = "backend-"
  image_id      = data.aws_ami.ubuntu_24.id
  instance_type = var.backend_instance_type
  key_name      = "demo-ec2"
  iam_instance_profile {
    name = "DemoEC2"  # Attach the IAM role
  }
  
  user_data = base64encode(<<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get install -y ansible git python3-pip python3-venv sshpass unzip
    export ANSIBLE_HOST_KEY_CHECKING=False
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

    curl -fsSL https://tailscale.com/install.sh | sh
    TS_AUTHKEY=$(aws ssm get-parameter --name "/tailscale/auth-key" --with-decryption --query Parameter.Value --output text --region us-east-1)

    sudo tailscale up --authkey=$TS_AUTHKEY

    python3 -m venv /home/ubuntu/myenv
    source /home/ubuntu/myenv/bin/activate
    pip install boto3 botocore

    VAULT_PASS=$(aws ssm get-parameter --name "/ansible/vault-pass" --with-decryption --query Parameter.Value --output text --region us-east-1)
    echo "$VAULT_PASS" > /home/ubuntu/.vault_pass.txt
    chmod 600 /home/ubuntu/.vault_pass.txt

    git clone https://github.com/nidhip24/CAS_DevOps /home/ubuntu/CAS_DevOps
    cd /home/ubuntu/CAS_DevOps/infra_setup/
    ansible-playbook k8s_docker_setup.yml
    ansible-playbook -i inventory.ini k8s_worker.yml  --vault-password-file /home/ubuntu/.vault_pass.txt
  EOF

    # ansible-playbook k8s_docker_setup.yml
    # ansible-playbook k8s_cluster_init.yml
  )
  
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.backend_sg_id]
  }
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "backend-instance"
      Role = "backend-worker"
    }
  }
}

# UI Auto Scaling Group
resource "aws_autoscaling_group" "ui" {
  name                = "ui-asg"
  vpc_zone_identifier = var.public_subnet_ids
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  
  launch_template {
    id      = aws_launch_template.ui.id
    version = "$Latest"
  }
  
  target_group_arns = [var.ui_target_group_arn]
  
  health_check_type         = "ELB"
  health_check_grace_period = 300
  
  tag {
    key                 = "Name"
    value               = "ui-asg"
    propagate_at_launch = true
  }
}

# Backend Auto Scaling Group
resource "aws_autoscaling_group" "backend" {
  name                = "backend-asg"
  vpc_zone_identifier = var.public_subnet_ids
  min_size            = 1
  max_size            = 2
  desired_capacity    = 1
  
  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }
  
  target_group_arns = [var.backend_target_group_arn]
  
  health_check_type         = "ELB"
  health_check_grace_period = 300
  
  tag {
    key                 = "Name"
    value               = "backend-asg"
    propagate_at_launch = true
  }
}

# UI Auto Scaling Policies
resource "aws_autoscaling_policy" "ui_scale_up" {
  name                   = "ui-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ui.name
}

resource "aws_autoscaling_policy" "ui_scale_down" {
  name                   = "ui-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ui.name
}

# Backend Auto Scaling Policies
resource "aws_autoscaling_policy" "backend_scale_up" {
  name                   = "backend-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.backend.name
}

resource "aws_autoscaling_policy" "backend_scale_down" {
  name                   = "backend-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.backend.name
}

# CloudWatch Alarms for UI Auto Scaling
resource "aws_cloudwatch_metric_alarm" "ui_high_cpu" {
  alarm_name          = "ui-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ui.name
  }

  alarm_description = "Scale up UI instances when CPU exceeds 70%"
  alarm_actions     = [aws_autoscaling_policy.ui_scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "ui_low_cpu" {
  alarm_name          = "ui-low-cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ui.name
  }

  alarm_description = "Scale down UI instances when CPU is below 30%"
  alarm_actions     = [aws_autoscaling_policy.ui_scale_down.arn]
}

# CloudWatch Alarms for Backend Auto Scaling
resource "aws_cloudwatch_metric_alarm" "backend_high_cpu" {
  alarm_name          = "backend-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.backend.name
  }

  alarm_description = "Scale up backend instances when CPU exceeds 70%"
  alarm_actions     = [aws_autoscaling_policy.backend_scale_up.arn]
}

resource "aws_cloudwatch_metric_alarm" "backend_low_cpu" {
  alarm_name          = "backend-low-cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.backend.name
  }

  alarm_description = "Scale down backend instances when CPU is below 30%"
  alarm_actions     = [aws_autoscaling_policy.backend_scale_down.arn]
} 