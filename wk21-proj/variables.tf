variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "my_keypair" {
  type    = string
  default = "LUIT_TEST_KEYS"
}

variable "my_instance_type" {
  description = "Type of instance for autoscaling group"
  type        = string
  default     = "t2.micro"
}

variable "ami_for_web_server" {
  description = "ami for the web server"
  type        = string
  default     = "ami-055864024342e0e66"
}