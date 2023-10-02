terraform {
  backend "s3" {
    # bucket  = "jkbucketdevops"
    bucket = "jk-terraform-state-file"
    key    = "jkarran/state-file"
    region = "us-east-1"
  }

  #     dynamodb_table = "terraform-locks"
  #     encrypt        = true
  #   }
  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "jkarran"
  #   workspaces {
  #     name = "my-aws-app-wk21"
  #   }
  # }

  # backend "local" {
  #   path = "terraform.tfstate"
  # }


  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }
}