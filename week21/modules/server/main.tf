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

locals {
  service_name = "Automation"
  app_team     = "Cloud Team"
  createdby    = "terraform"

}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name"      = var.vpc_name
    "Service"   = local.service_name
    "AppTeam"   = local.app_team
    "CreatedBy" = local.createdby
  }
}


# locals {
#   # Common tags to be assigned to all resources
#   common_tags = {
#     Name      = aws_vpc.main.tags.Name
#     Service   = local.service_name
#     AppTeam   = local.app_team
#     CreatedBy = local.createdby
#   }
# }

# variable "vpc_name" {
#   type    = string
#   default = "jk-test"
# }

resource "aws_subnet" "list_subnet" {
  for_each          = var.env
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.ip
  availability_zone = each.value.az
}