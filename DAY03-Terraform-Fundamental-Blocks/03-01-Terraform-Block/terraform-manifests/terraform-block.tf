# Terraform Block
terraform {
  required_version = "~>1.3.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

}

provider "aws" {
  region = "us-east-1"  
  profile = "default111"
  
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "myvpc"
  }
}

/*
Play with Terraform Version
  required_version = "~> 0.14.3" 
  required_version = "= 0.14.4"  
  required_version = ">= 0.13"   
  required_version = "= 0.13"    
  required_version = "~> 0.13"   


Play with Provider Version
      version = "~> 3.0"            
      version = ">= 3.0.0, < 3.1.0"
      version = ">= 3.0.0, <= 3.1.0"
      version = "~> 2.0"
      version = "~> 3.0"            
*/

