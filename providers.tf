terraform {
  required_version = ">= 1.5.0" 
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 5.0.0" 
      configuration_aliases = [aws.us-east-1] 
    }
  }
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1" 
}
