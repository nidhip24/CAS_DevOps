provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  
  backend "s3" {
    bucket  = "cas-terraform-states"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

# VPC and Network Infrastructure
module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  database_subnets   = var.database_subnets
}

# Security Groups
module "security_groups" {
  source = "./modules/security_groups"
  
  vpc_id = module.vpc.vpc_id
}

# Load Balancers
module "load_balancers" {
  source = "./modules/load_balancers"
  
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ui_sg_id          = module.security_groups.ui_sg_id
  backend_sg_id     = module.security_groups.backend_sg_id
}

# Auto Scaling Groups
module "auto_scaling" {
  source = "./modules/auto_scaling"
  
  vpc_id                   = module.vpc.vpc_id
  public_subnet_ids        = module.vpc.public_subnet_ids
  ui_sg_id                 = module.security_groups.ui_sg_id
  backend_sg_id            = module.security_groups.backend_sg_id
  ui_target_group_arn      = module.load_balancers.ui_target_group_arn
  backend_target_group_arn = module.load_balancers.backend_target_group_arn
  ui_instance_type         = var.ui_instance_type
  backend_instance_type    = var.backend_instance_type
}

# RDS Database
module "rds" {
  source = "./modules/rds"
  
  vpc_id              = module.vpc.vpc_id
  database_subnet_ids = module.vpc.database_subnet_ids
  db_sg_id            = module.security_groups.db_sg_id
  db_instance_class   = var.db_instance_class
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
}

# WAF Configuration
module "waf" {
  source = "./modules/waf"
  
  alb_arn = module.load_balancers.alb_arn
} 