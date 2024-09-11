variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "key_name" {
  description = "Key pair name for accessing EC2 instances"
}

variable "allowed_ips" {
  description = "Allowed CIDR blocks for SSH access to Bastion Host"
  type        = list(string)
}
