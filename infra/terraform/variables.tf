variable "project_name" {
  type        = string
  description = "Project/service name prefix."
  default     = "claimpilot-pro"
}

variable "environment" {
  type        = string
  description = "Environment name."
  default     = "prod"
}

variable "aws_region" {
  type        = string
  description = "AWS region."
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.20.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.20.11.0/24", "10.20.12.0/24"]
}

variable "app_port" {
  type    = number
  default = 8000
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "asg_min_size" {
  type    = number
  default = 1
}

variable "asg_max_size" {
  type    = number
  default = 2
}

variable "asg_desired_capacity" {
  type    = number
  default = 1
}

variable "app_image" {
  type        = string
  description = "Container image URI (ECR recommended), e.g. 123.dkr.ecr.us-east-1.amazonaws.com/claimpilot:latest"
}

variable "gemini_api_key" {
  type        = string
  sensitive   = true
  description = "Gemini API key for model calls."
}

variable "cors_origins" {
  type        = string
  description = "Comma-separated CORS origins."
  default     = "https://example.com"
}

variable "db_name" {
  type    = string
  default = "claimpilot"
}

variable "db_username" {
  type    = string
  default = "claimpilot"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "RDS master password."
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  type    = number
  default = 20
}

variable "alert_email" {
  type        = string
  description = "SNS email for high-priority alerts."
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

variable "upload_cors_allowed_origins" {
  type        = list(string)
  description = "Allowed browser origins for direct S3 uploads."
  default     = ["https://example.com"]
}

variable "db_multi_az" {
  type        = bool
  description = "Enable Multi-AZ for RDS."
  default     = false
}

variable "db_backup_retention_period" {
  type        = number
  description = "RDS backup retention in days."
  default     = 0
}
