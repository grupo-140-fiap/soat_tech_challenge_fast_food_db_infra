locals {
  env = "dev"
  region = "us-east-1"
  eks_name = "eks-${var.project_name}-${local.env}"
  eks_version = "1.29"
}
