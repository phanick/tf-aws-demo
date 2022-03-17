
  # Create AWS ec2 instance
  resource "aws_instance" "ubuntu-tf" {
  ami = var.ami_id
  # vpc_id = "vpc-0043430975cdcbb92"
  key_name = var.key_name
  instance_type = var.instance_type
  # security_groups= var.security_group
  tags= {
    Name = var.tag_name
  }
}

