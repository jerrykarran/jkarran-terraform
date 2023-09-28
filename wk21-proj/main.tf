# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = "jk-vpc-terraform"
  cidr               = "10.0.0.0/16"
  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
  enable_nat_gateway = true
  enable_vpn_gateway = true
}

resource "aws_ec2_tag" "private_subnet_tag1" {
  resource_id = module.vpc.private_subnets[0]
  key         = "Name"
  value       = "Private Subnet 1"
}

resource "aws_ec2_tag" "private_subnet_tag2" {
  resource_id = module.vpc.private_subnets[1]
  key         = "Name"
  value       = "Private Subnet 2"
}

resource "aws_ec2_tag" "public_subnet_tag1" {
  resource_id = module.vpc.public_subnets[0]
  key         = "Name"
  value       = "Public Subnet 1"
}

resource "aws_ec2_tag" "public_subnet_tag2" {
  resource_id = module.vpc.public_subnets[1]
  key         = "Name"
  value       = "Public Subnet 2"
}

module "autoscaling" {
  source = "github.com/terraform-aws-modules/terraform-aws-autoscaling"
  # Autoscaling group
  name                      = "jk_auto_scaling_group"
  vpc_zone_identifier       = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  # Launch template
  create_launch_template = true
  image_id               = var.ami_for_web_server
  # user_data     = file("jk_user_data.sh")
  instance_type          = var.my_instance_type
  security_groups = [module.security-group.security_group_id]
  tags = {
    Name = "Apache Server from ASG"
  }
}


module "security-group" {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"
  # security group with internet access and assiciated with asg instances
  name        = "Security Group from Terraform"
  description = "Allow internet traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  egress_rules       = ["all-all"]
}


module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"
  name = "my-terraform-alb"
  load_balancer_type = "application"

  vpc_id             = module.vpc.vpc_id
  subnets            = [module.vpc.public_subnets[0], module.vpc.public_subnets[1]]
  security_groups    = [module.security-group.security_group_id]
  security_group_rules = {
    ingress_all_http = {
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP web traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  # access_logs = {
  #   bucket = "my-alb-logs"
  # }
  
  http_tcp_listeners = [
    # Forward action is default, either when defined or undefined
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      # action_type        = "forward"
    },
  ]

  target_groups = [
    {
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/healthz"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  ]
}