variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets"
  type        = list(string)
}

variable "ui_sg_id" {
  description = "ID of the UI security group"
  type        = string
}

variable "backend_sg_id" {
  description = "ID of the backend security group"
  type        = string
}

variable "ui_target_group_arn" {
  description = "ARN of the UI target group"
  type        = string
}

variable "backend_target_group_arn" {
  description = "ARN of the backend target group"
  type        = string
}

variable "ui_instance_type" {
  description = "Instance type for UI servers"
  type        = string
  default     = "t3.micro"
}

variable "backend_instance_type" {
  description = "Instance type for backend servers"
  type        = string
  default     = "t3.micro"
} 