terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.18.0"
    }
  }

  backend "s3" {
    bucket         = "jkbucketdevops"
    key            = "https://jkbucketdevops.s3.amazonaws.com/confidential"
    region         = "us-east-1"
    encrypt        = true
  }
}

# module "s3_bucket" {
#   source = "github.com/terraform-aws-modules/terraform-aws-s3-bucket"
#   bucket = var.asg_s3_bucket
#   control_object_ownership = true
#   object_ownership         = "ObjectWriter"
# }