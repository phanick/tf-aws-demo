variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "aws-keys-2709"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}

variable "security_group" {
  description = "Name of security group"
  default     = "sg-04caa8dfc5857a16d"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "ubuntu-tf-01"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-0747bdcabd34c712a"
}
