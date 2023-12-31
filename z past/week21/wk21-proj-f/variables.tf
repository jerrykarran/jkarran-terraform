variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "asg_image_id" {
  type    = string
  default = "ami-097b85dfebf18517e"
}

variable "asg_instance_type" {
  description = "Type of instance for autoscaling group"
  type        = string
  default     = "t2.micro"
}

variable "asg_subnet_1" {
  description = "Subnet 1 for autoscaling group"
  type        = string
  default     = "subnet-0b8e60f318149a9b8"
}

variable "asg_subnet_2" {
  description = "Subnet 2 for autoscaling group"
  type        = string
  default     = "subnet-07305823a74cd57b5"
}

variable "vpc_id" {
  type    = string
  default = "vpc-06279afac18507d28"
}