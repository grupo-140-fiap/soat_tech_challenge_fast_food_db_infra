variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for resources"
}

variable "aws_profile" {
  type        = string
  #default     = "default"
  description = "AWS CLI profile to use"
}

variable "project_name" {
  type        = string
  default     = "soat-fast-food"
  description = "Project name for resource naming"
}

variable "db_identifier" {
  type        = string
  default     = "soatfastfood"
  description = "RDS instance identifier"
}

variable "db_name" {
  type        = string
  default     = "fast_food_db"
  description = "Database name to create"
}

variable "db_username" {
  type        = string
  default     = "app_user"
  description = "Master username for the RDS instance"
}

variable "db_password" {
  type        = string
  description = "Master password for the RDS instance"
  #sensitive   = true
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "RDS instance class"
}

variable "db_allocated_storage" {
  type        = number
  default     = 20
  description = "Allocated storage in GB"
}

variable "multi_az" {
  type        = bool
  default     = false
  description = "Enable Multi-AZ deployment"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Whether the RDS instance is publicly accessible"
}
