terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
backend "s3" {
    bucket = "aws-terra-project"
    key    = "states/terraform.tfstate"
    region = "us-east-1" 
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
