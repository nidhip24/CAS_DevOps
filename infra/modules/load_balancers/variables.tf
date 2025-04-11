variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnets"
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

variable "certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listeners"
  type        = string
  default     = null
} 