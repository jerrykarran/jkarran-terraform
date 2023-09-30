terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.18.0"
    }
  }

  # backend "http" {
  #   address        = "http://localhost:5000/terraform_state/4cdd0c76-d78b-11e9-9bea-db9cd8374f3a"
  #   lock_address   = "http://localhost:5000/terraform_lock/4cdd0c76-d78b-11e9-9bea-db9cd8374f3a"
  #   lock_method    = "PUT"
  #   unlock_address = "http://localhost:5000/terraform_lock/4cdd0c76-d78b-11e9-9bea-db9cd8374f3a"
  #   unlock_method  = "DELETE"
  # }
// s3 backend setup
  backend "s3" {
    # bucket  = "jkbucketdevops"
    bucket = "jk-terraform-state-file"
    key    = "jkarran/state-file"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
  required_version = ">=1.0.0"
}

# module "s3_bucket" {
#   source                   = "github.com/terraform-aws-modules/terraform-aws-s3-bucket"
#   bucket                   = var.asg_s3_bucket
#   control_object_ownership = true
#   object_ownership         = "ObjectWriter"
# }