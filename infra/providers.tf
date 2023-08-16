terraform {
  required_version = ">=1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0.0"
      
    
    }
     helm = {
      source = "hashicorp/helm"
      version = ">=2.10.1"
    }
     kubectl = {
      source = "gavinbunney/kubectl"
      version = ">=1.14.0"
    }
  }
  # backend "s3" {
  #   bucket = "terraform-tfstate"
  #   key = "project-tfstate"
  #   region = "ap-south-1"
  #   dynamodb_table = "terraform-dynamodb"
  #   encrypt = true
  #   depends_on = [module.s3]
  # }
}

provider "aws" {
  region = "ap-south-1"
  #profile = "AWSAdministratorAccess-194510975891"
  #access_key = var.aws_access_key
  #secret_key = var.aws_secret_key
}
