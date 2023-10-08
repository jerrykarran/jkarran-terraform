# # --------Security Group-DB-child --------#
# module "security_group_db" {
#   source = "github.com/terraform-aws-modules/terraform-aws-security-group"
#   # security group with internet access and assiciated with asg instances
# #   name                = var.public_security_group_name
#   vpc_id              = module.vpc.vpc_id
#   ingress_cidr_blocks = ["0.0.0.0/0"]
#   egress_rules        = ["all-all"]
#   ingress_with_source_security_group_id = [
#     {
#       rule                     = "mysql-tcp"
#       source_security_group_id = module.security_group_web_server.security_group_id
#     },
#   ]
# }