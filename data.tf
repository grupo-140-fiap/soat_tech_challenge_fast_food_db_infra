# data "aws_vpc" "default" {
#   default = true
# }

data "aws_vpc" "main" {
  id = var.vpc_name
}

data "aws_subnets" "main" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_security_groups" "main" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

# data "aws_eks_cluster" "eks" {
#   name = "${local.eks_name}"
# }


output "security_groups" {
  description = "The security_groups from vpc"
  value       = data.aws_security_groups.main.ids
}

output "subnets" {
  description = "The aws_subnets from vpc"
  value       = data.aws_subnets.main.ids
}