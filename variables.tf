variable "project_name" {
  type        = string
  default     = "soat-fast-food"
  description = "The project name"
}

variable "db_password" {
  type        = string
  default     = ""
  description = "The password for the RDS databasename"
}

variable "vpc_name" {
  type        = string
  default     = ""
  description = "VPC Name"
}

variable "role_arn" {
  type        = string
  default     = ""
  description = "Role ARN to assume"
}

variable "region" {
  type        = string
  default     = ""
  description = "region env"
}