terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.14.3"
}

# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
    assume_role {
    role_arn = var.aws_profile
  }
}