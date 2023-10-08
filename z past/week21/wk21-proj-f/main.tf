module "asg" {
  source = "github.com/terraform-aws-modules/terraform-aws-autoscaling"
  # Autoscaling group
  name = "jk_auto_scaling_group"

  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = [var.asg_subnet_1, var.asg_subnet_2]


  # Launch template
  launch_template_name        = "jk_asg_launch_template"
  launch_template_description = "Launch template for asg"
  update_default_version      = true
  image_id                    = var.asg_image_id
  instance_type               = var.asg_instance_type
  user_data                   = "IyEvYmluL2Jhc2gKIyBjcmVhdGVkIGJ5IEplcnJ5IEthcnJhbiAtIExVSVQtUmVkLVRlYW0tMjAyMwoKIyBwZXJmb3JtIGxpbnV4IHVwZGF0ZQpzdWRvIHl1bSB1cGRhdGUgLXkKCiMgaW5zdGFsbCBBcGFjaGUgV2ViIFNlcnZlcgpzdWRvIHl1bSBpbnN0YWxsIC15IGh0dHBkCgojIHN0YXJ0IHRoZSBBcGFjaGUgV2ViIFNlcnZlcgpzdWRvIHN5c3RlbWN0bCBzdGFydCBodHRwZAoKCiMgZW5hYmxlIGl0IHRvIHN0YXJ0IG9uIGJvb3QKc3VkbyBzeXN0ZW1jdGwgZW5hYmxlIGh0dHBkCgpjZCAvdmFyL3d3dy9odG1sCgplY2hvICc8Y2VudGVyPjxoMT5XZWxjb21lIHRvIExVSVQgLSBUZWFtIDxmb250IGNvbG9yPSJyZWQiPlJlZDwvZm9udD48L2gxPjwvY2VudGVyPicgfCBzdWRvIHRlZSBpbmRleC5odG1s"
  security_groups             = [module.security-group.security_group_id]
}

module "security-group" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"
  # security group with internet access and assiciated with asg instances
  name        = "Security Group for Terraform"
  description = "Allow traffic on ports 443, 80, and ssh"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}