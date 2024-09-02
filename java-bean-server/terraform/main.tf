terraform {

  required_version = ">= 1.0.0"
  backend "s3" {
    bucket         = "free-the-beans-terraform-backend"
    key            = "free-the-beans/rds/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "free-the-beans-db-terraform-lock"
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      "owner"         = var.aws_resource_owner
      "created-using" = "terraform"
    }
  }

}


