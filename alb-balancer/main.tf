terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.38.0"
    }
  }
  required_version = ">= 0.14.9"

}

provider "aws" {
  region = var.region
}