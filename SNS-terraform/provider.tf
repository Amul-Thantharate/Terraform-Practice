terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws" 
            version = "~> 3.08"
    }
}
}

provider "aws" {
    region = "us-east-1"
}

