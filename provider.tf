terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.13.2"
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.role_arn
  }
}
