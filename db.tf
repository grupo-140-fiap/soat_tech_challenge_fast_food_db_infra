########################
# RDS for Fast-Food App
########################

# Security Group scoped to the VPC; allow MySQL only from VPC CIDR
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-sg-${var.project_name}-"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.networking.outputs.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Subnet group using private subnets from networking remote state
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group-${var.project_name}"
  subnet_ids = data.terraform_remote_state.networking.outputs.private_subnet_ids
}

# MySQL RDS instance
resource "aws_db_instance" "mysql_db" {
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  identifier        = var.db_identifier
  db_name           = var.db_name
  username          = var.db_username
  password          = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  multi_az            = var.multi_az
  publicly_accessible = var.publicly_accessible
  skip_final_snapshot = true
  deletion_protection = false
}

########################
# Outputs
########################

output "rds_endpoint" {
  description = "The endpoint of the RDS database"
  value       = aws_db_instance.mysql_db.address
}

output "rds_port" {
  description = "The port of the RDS database"
  value       = aws_db_instance.mysql_db.port
}

output "rds_username" {
  description = "The username for the RDS database"
  value       = aws_db_instance.mysql_db.username
}

output "rds_db_name" {
  description = "The initial database name"
  value       = aws_db_instance.mysql_db.db_name
}

output "rds_security_group_id" {
  description = "Security group protecting the RDS instance"
  value       = aws_security_group.rds_sg.id
}

output "rds_subnet_group_name" {
  description = "Subnet group used by the RDS instance"
  value       = aws_db_subnet_group.rds_subnet_group.name
}

