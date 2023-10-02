provider "aws" {
  region = "us-east-1"
}
# resource "aws_instance" "web" {
#   ami                    = var.ami
#   instance_type          = var.size
#   subnet_id              = var.subnet_id
#   vpc_security_group_ids = var.security_groups

#   tags = {
#     "Name"        = "Server from Module"
#     "Environment" = "Training"
#   }
# }

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "terraform Edit"
  }
}