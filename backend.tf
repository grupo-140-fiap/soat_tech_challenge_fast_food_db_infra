terraform {
  backend "s3" {
    bucket  = "soat-fast-food-infra-terraform-states"
    key     = "rds/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
