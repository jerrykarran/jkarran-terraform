# set your provider
provider "aws" {
  region = var.aws_region
}

# launch the jenkins server instance
resource "aws_instance" "jenkins_server" {
  ami           = var.jenkins_ami
  instance_type = var.jenkins_instance_type
  key_name      = var.key_pair
  user_data     = file("jenkins_server_user_data.sh")
  tags = {
    Name = "Jenkins Server"
  }
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
}

# create the security group
resource "aws_security_group" "jenkins_security_group" {
  name        = "jenkins_security_group"
  description = "allow traffic on on port 22 and 8080"
  # vpc_id      = var.my_vpc_id

  ingress {
    description = "Allow 8080 from the Internet"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow 22 from the Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_private_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "jenkins_security_group"
  }
}

# create your bucket
resource "aws_s3_bucket" "private_bucket" {
  bucket = var.private_bucket_name
  tags = {
    Name = "My Private Bucket"
  }
}


# resource "aws_iam_role" "jenkins-role" {
#   name = "jenkins-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action   = "*"
#         Effect   = "Allow"
#         Resource = "*"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       },
#     ]
#   })
# }