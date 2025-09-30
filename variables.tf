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