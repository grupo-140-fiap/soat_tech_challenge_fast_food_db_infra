# resource "aws_subnet" "rds_subnets" {
#   count             = 2
#   vpc_id            = "${data.aws_vpc.main.id}"
#   cidr_block        = "10.2.${count.index + 2}.0/24"
#   availability_zone = "us-east-1a" # Example
# }

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  name_prefix = "rds-sg-${var.project_name}"
  vpc_id      = "${data.aws_vpc.main.id}"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [data.aws_security_groups.main.ids[0]] # Allow connections from EKS nodes
  } # module.eks.node_security_group_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = data.aws_subnets.main.ids
} # module.vpc.private_subnets

# MySQL RDS instance
resource "aws_db_instance" "mysql_db" {
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  identifier             = "soatfastfood"
  username               = "app_user"
  password               = "app_password"
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = true
  multi_az               = false
}

# # IAM Policy for RDS access via IAM DB Authentication
# resource "aws_iam_policy" "rds_iam_policy" {
#   name        = "rds-iam-auth-policy-${var.project_name}"
#   description = "Allows pods to authenticate with RDS using IAM"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Action   = "rds-db:connect",
#         Resource = "arn:aws:rds-db:us-east-1:${data.aws_caller_identity.current.account_id}:dbuser:${aws_db_instance.mysql_db.id}/dbuser"
#       }
#     ]
#   })
# }



# # IAM Role and Service Account for EKS pod
# resource "aws_iam_role" "irsa_role" {
#   name               = "irsa-rds-access-${var.project_name}"
#   assume_role_policy = module.eks.irsa_assume_role_policy
# }

# resource "aws_iam_role_policy_attachment" "irsa_policy_attach" {
#   role       = aws_iam_role.irsa_role.name
#   policy_arn = aws_iam_policy.rds_iam_policy.arn
# }

# output "rds_endpoint" {
#   description = "The endpoint of the RDS database"
#   value       = aws_db_instance.mysql_db.endpoint
# }



output "rds_username" {
  description = "The username for the RDS database"
  value       = aws_db_instance.mysql_db.username
}

# output "kubeconfig" {
#   description = "The generated kubeconfig for EKS cluster access"
#   value       = module.eks.kubeconfig
# }