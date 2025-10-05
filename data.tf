data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    bucket  = "soat-fast-food-terraform-states"
    key     = "1-networking/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}
