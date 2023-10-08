# --------Security Group-Public-child --------#
resource "aws_security_group" "security_group_public" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"
  # security group with internet access and assiciated with asg instances
  # name                = var.public_security_group_name
  description         = "Allow internet traffic and SSH"
  # vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}