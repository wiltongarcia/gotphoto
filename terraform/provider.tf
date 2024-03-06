provider "aws" {
  region                      = "eu-central-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style = true

  endpoints {
    s3             = "http://localstack:4566"
  }
}

terraform {
  required_version = "= 1.7.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.39.1"
    }

    null = {
      source  = "hashicorp/null"
      version = ">= 3.2.2"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.1"
    }
  }

#  backend "s3" {
#    bucket         = "terraform-state"
#    key            = "terraform/state"
#    region         = "eu-central-1"  # Change to your desired AWS region
#  }
}

