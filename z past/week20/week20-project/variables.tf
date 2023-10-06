# set your aws region
variable "aws_region" {
  description = "Region where the environment will be"
  type        = string
  default     = "us-east-1"
}
# set your ami
variable "jenkins_ami" {
  description = "ami that will be used for jenkins"
  type        = string
  default     = "ami-00c6177f250e07ec1"
}
# set your instance type
variable "jenkins_instance_type" {
  description = "instance type to be used for jenkins"
  type        = string
  default     = "t2.micro"
}
# set the vpc to use, skip for default vpc
variable "my_vpc_id" {
  description = "vpc to be used for jenkins"
  type        = string
  default     = "vpc-06279afac18507d28"
}
# set your private ip
variable "my_private_cidr" {
  description = "this is your private cidr"
  type        = string
  default     = "148.75.58.37/32"
}
# set your key pair
variable "key_pair" {
  description = "my keypair"
  type        = string
  default     = "LUIT_TEST_KEYS"
}
variable "private_bucket_name" {
  description = "bucket name"
  type        = string
   default    = "jerry-jenkins-093023"
}