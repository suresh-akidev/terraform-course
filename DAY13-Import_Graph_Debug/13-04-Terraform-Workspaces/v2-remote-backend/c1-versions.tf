# Terraform Block
terraform {
  required_version = "~> 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "billing-report-157673692367"
    key    = "workspaces/terraform.tfstate"
    region = "ap-south-1" 

    # For State Locking
    #dynamodb_table = "terraform-dev-state-table"     
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}

