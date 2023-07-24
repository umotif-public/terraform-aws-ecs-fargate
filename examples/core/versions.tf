terraform {
  required_version = "1.0.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
