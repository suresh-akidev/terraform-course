# Terraform Block
terraform {
  required_version = "~> 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "terra-157673692367"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1" 
    dynamodb_table = "terraform-dev-state-table"      
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}
