# --------variables.tf --------#

variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "vpc_name" {
  type    = string
  default = "jk-vpc-2-tier-terraform"
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "azs" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}
variable "public_subnets_cidrs" {
  type    = list(any)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}
variable "private_subnets_cidrs" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "public_instance_name1" {
  type    = string
  default = "Web Server 1"
}
variable "public_instance_name2" {
  type    = string
  default = "Web Server 2"
}
variable "private_instance_name" {
  type    = string
  default = "RDS"
}


variable "db_instance_class" {
  description = "Size of instance class for db"
  type        = string
  default     = "db.t2.micro"
}
variable "db_identifier" {
  type    = string
  default = "jk-luit"
}
variable "db_family" {
  type    = string
  default = "mysql5.7"
}
variable "db_major_engine_version" {
  type    = string
  default = "5.7"
}
variable "engine_version" {
  type    = string
  default = "5.7"
}
variable "db_engine" {
  type    = string
  default = "mysql"
}

variable "db_allocated_storage" {
  type    = string
  default = "5"
}
variable "db_username" {
  type    = string
  default = "username_jk"
}
variable "db_port" {
  type    = string
  default = "3306"
}
variable "is_db_storage_encrypted" {
  type    = string
  default = "false"
}
variable "instance_type" {
  description = "Size of instance"
  type        = string
  default     = "t2.micro"
}

variable "public_instance_ami" {
  type    = string
  default = "ami-097b85dfebf18517e"
}
variable "key_name" {
  type    = string
  default = "LUIT_TEST_KEYS"
}

variable "public_security_group_name" {
  type    = string
  default = "Web Server Security Group"
}
variable "private_security_group_name" {
  type    = string
  default = "RDS Security Group"
}
# variable "xxxxxxxx" {
#   type    = string
#   default = "xxxxxxxx"
# }
# variable "security_groups" {
#   type    = list(any)
#   default = ["sg-03588332a44614c9c"]
# }
