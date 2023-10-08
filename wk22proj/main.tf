# --------main.tf --------#

# create your vpc with subnets and routing tables
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



# our public web instance 1
module "ec2_instance_public1" {
  # source                      = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  source                 = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  ami                    = var.public_instance_ami
  user_data              = "IyEvYmluL2Jhc2gKIyBjcmVhdGVkIGJ5IEplcnJ5IEthcnJhbiAtIExVSVQtUmVkLVRlYW0tMjAyMwoKIyBwZXJmb3JtIGxpbnV4IHVwZGF0ZQpzdWRvIHl1bSB1cGRhdGUgLXkKCiMgaW5zdGFsbCBBcGFjaGUgV2ViIFNlcnZlcgpzdWRvIHl1bSBpbnN0YWxsIC15IGh0dHBkCgojIHN0YXJ0IHRoZSBBcGFjaGUgV2ViIFNlcnZlcgpzdWRvIHN5c3RlbWN0bCBzdGFydCBodHRwZAoKCiMgZW5hYmxlIGl0IHRvIHN0YXJ0IG9uIGJvb3QKc3VkbyBzeXN0ZW1jdGwgZW5hYmxlIGh0dHBkCgpjZCAvdmFyL3d3dy9odG1sCgplY2hvICc8Y2VudGVyPjxoMT5XZWxjb21lIHRvIExVSVQgLSBUZWFtIDxmb250IGNvbG9yPSJyZWQiPlJlZDwvZm9udD48L2gxPjwvY2VudGVyPicgfCBzdWRvIHRlZSBpbmRleC5odG1s"
  name                   = var.public_instance_name1
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[0]
  key_name               = var.key_name
  vpc_security_group_ids = [module.security_group_public.security_group_id]
  # vpc_security_group_ids      = [module.security_group_public.public_security_group]
  associate_public_ip_address = true
}
# # our public web instance 2
# module "ec2_instance_public2" {
#   source                      = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
#   ami                         = var.public_instance_ami
#   user_data                   = "IyEvYmluL2Jhc2gKIyBjcmVhdGVkIGJ5IEplcnJ5IEthcnJhbiAtIExVSVQtUmVkLVRlYW0tMjAyMwoKIyBwZXJmb3JtIGxpbnV4IHVwZGF0ZQpzdWRvIHl1bSB1cGRhdGUgLXkKCiMgaW5zdGFsbCBBcGFjaGUgV2ViIFNlcnZlcgpzdWRvIHl1bSBpbnN0YWxsIC15IGh0dHBkCgojIHN0YXJ0IHRoZSBBcGFjaGUgV2ViIFNlcnZlcgpzdWRvIHN5c3RlbWN0bCBzdGFydCBodHRwZAoKCiMgZW5hYmxlIGl0IHRvIHN0YXJ0IG9uIGJvb3QKc3VkbyBzeXN0ZW1jdGwgZW5hYmxlIGh0dHBkCgpjZCAvdmFyL3d3dy9odG1sCgplY2hvICc8Y2VudGVyPjxoMT5XZWxjb21lIHRvIExVSVQgLSBUZWFtIDxmb250IGNvbG9yPSJyZWQiPlJlZDwvZm9udD48L2gxPjwvY2VudGVyPicgfCBzdWRvIHRlZSBpbmRleC5odG1s"
#   name                        = var.public_instance_name2
#   instance_type               = var.instance_type
#   subnet_id                   = module.vpc.public_subnets[1]
#   key_name                    = var.key_name
#   vpc_security_group_ids      = [module.security_group_public.security_group_id]
#   associate_public_ip_address = true
# }

# security group with internet and ssh access for your public instances
module "security_group_public" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"
  # source = "./security_group_public"
  # security group with internet access and ssh access
  name                = var.public_security_group_name
  description         = "Allow internet traffic and SSH"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
  tags = {
    Key   = "Name"
    Value = var.public_security_group_name
  }
}


# # rds 
# module "db" {
#   source     = "terraform-aws-modules/rds/aws"
#   identifier = var.db_identifier

#   # DB parameter group
#   family = var.db_family
#   # DB option group
#   major_engine_version = var.db_major_engine_version
#   engine_version       = var.engine_version
#   engine               = var.db_engine
#   storage_encrypted = var.is_db_storage_encrypted

#   instance_class    = var.db_instance_class
#   allocated_storage = var.db_allocated_storage

#   db_name  = var.private_instance_name
#   username = var.db_username
#   port     = var.db_port

#   # iam_database_authentication_enabled = true

#   vpc_security_group_ids = [module.security_group_db.security_group_id]

#   # DB subnet group
#   create_db_subnet_group = true
#   subnet_ids             = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
# }

# # security group for your rds
# module "security_group_db" {
#   source = "github.com/terraform-aws-modules/terraform-aws-security-group"
#   # security group with access from your web server
#   name                = var.private_security_group_name
#   vpc_id              = module.vpc.vpc_id
#   ingress_cidr_blocks = ["0.0.0.0/0"]
#   egress_rules        = ["all-all"]
#   ingress_with_source_security_group_id = [
#     {
#       rule                     = "mysql-tcp"
#       source_security_group_id = module.security_group_public.security_group_id
#     },
#   ]
# }