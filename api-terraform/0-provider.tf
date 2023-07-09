terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "3.38.0"
        }
    random = {
        source = "hashicorp/random"
        version = "3.1.0"
    }
    archive = {
        source = "hashicorp/archive"
        version = "2.2.0"
    }
    
    }
    required_version = ">= 0.14.9"
}

provider "aws" {
    region = "us-east-1"
}

