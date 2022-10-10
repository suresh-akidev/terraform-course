terraform {
  # Required Terraform Version
  required_version = "~> 1.3.0"
  # Required Providers and their Versions
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.21" # Optional but recommended
    }
    random = {
      source = "hashicorp/random"
      version = "3.0.1"
    }
  }
  # Remote Backend for storing Terraform State in S3 bucket 
  backend "s3" {
    bucket = "mybucket"
    key    = "path/to/my/key"
    region = "us-east-1"
  }

}
