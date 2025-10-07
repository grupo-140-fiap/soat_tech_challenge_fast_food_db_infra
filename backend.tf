terraform {
  backend "s3" {
    bucket  = "soat-fast-food-terraform-states"
    key     = "rds/terraform.tfstate"
    region  = "us-east-1"
    profile = var.aws_profile
    encrypt = true
  }
}