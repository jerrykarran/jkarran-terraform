provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc"
  name   = var.vpc_name
  cidr   = var.vpc_cidr
  azs    = var.azs
  # for rds tier
  private_subnets = var.private_subnets_cidrs
  # for web server tier
  public_subnets     = var.public_subnets_cidrs
  enable_nat_gateway = false
  enable_vpn_gateway = false
}
# name our subnets
resource "aws_ec2_tag" "web_server_subnet1" {
  resource_id = module.vpc.public_subnets[0]
  key         = "Name"
  value       = "Web Server Subnet 1"
}
resource "aws_ec2_tag" "web_server_subnet2" {
  resource_id = module.vpc.public_subnets[1]
  key         = "Name"
  value       = "Web Server Subnet 2"
}
resource "aws_ec2_tag" "rds_subnet1" {
  resource_id = module.vpc.private_subnets[0]
  key         = "Name"
  value       = "RDS Subnet 1"
}
resource "aws_ec2_tag" "rds_subnet2" {
  resource_id = module.vpc.private_subnets[1]
  key         = "Name"
  value       = "RDS Subnet 2"
}

module "ec2-instance" {
  source                      = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  ami                         = var.public_instance_ami
  user_data                   = "IyEvYmluL2Jhc2gKIyBjcmVhdGVkIGJ5IEplcnJ5IEthcnJhbiAtIExVSVQtUmVkLVRlYW0tMjAyMwoKIyBwZXJmb3JtIGxpbnV4IHVwZGF0ZQpzdWRvIHl1bSB1cGRhdGUgLXkKCiMgaW5zdGFsbCBBcGFjaGUgV2ViIFNlcnZlcgpzdWRvIHl1bSBpbnN0YWxsIC15IGh0dHBkCgojIHN0YXJ0IHRoZSBBcGFjaGUgV2ViIFNlcnZlcgpzdWRvIHN5c3RlbWN0bCBzdGFydCBodHRwZAoKCiMgZW5hYmxlIGl0IHRvIHN0YXJ0IG9uIGJvb3QKc3VkbyBzeXN0ZW1jdGwgZW5hYmxlIGh0dHBkCgpjZCAvdmFyL3d3dy9odG1sCgplY2hvICc8Y2VudGVyPjxoMT5XZWxjb21lIHRvIExVSVQgLSBUZWFtIDxmb250IGNvbG9yPSJyZWQiPlJlZDwvZm9udD48L2gxPjwvY2VudGVyPicgfCBzdWRvIHRlZSBpbmRleC5odG1s"
  name                        = var.public_instance_name1
  instance_type               = var.instance_type
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = var.key_name
  vpc_security_group_ids      = [module.security_group_web_server.security_group_id]
  associate_public_ip_address = true
}
# module "ec2-instance" {
#   source        = "terraform-aws-modules/ec2-instance/aws"
#   ami = var.public_instance_ami
#   name          = var.public_instance_name1
#   instance_type = var.instance_type
# #   vpc_security_group_ids = ["sg-12345678"]
#   subnet_id              = module.vpc.public_subnets[1]
# }

# module "ec2-instance" {
#   source        = "terraform-aws-modules/ec2-instance/aws"
#   ami = 
#   name          = var.private_instance_name1
#   instance_type = var.instance_type
# }


module "security_group_web_server" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"
  # security group with internet access and assiciated with asg instances
  name                = var.public_security_group_name
  description         = "Allow internet traffic and SSH"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

module "security-group_db" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"
  # security group with internet access and assiciated with asg instances
  name                = var.private_security_group_name
  description         = "Allow internet traffic and SSH"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # ingress_rules       = ["mysql-tcp"]
  egress_rules        = ["all-all"]
  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.security_group_web_server.security_group_id
    },
  ]
}