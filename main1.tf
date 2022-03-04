# Create VPC 
resource "aws_vpc" "tf-vpc" {
  cidr_block  = "${var.vpc_cidr}" 
  enable_dns_hostnames = true
  tags = {
    Name = "tf-demo-vpc"
  }
}
output "aws_vpc_id" {
	value = "${aws_vpc.tf-vpc.id}"
}

# Create Subnets ##
resource "aws_subnet" "tf-subnet" {
  vpc_id     = "${aws_vpc.tf-vpc.id}"
  cidr_block ="${var.subnet_cidr}"
availability_zone = "us-east-2a"

  tags = {
    Name = "tf-demo-subnet"
  }
}
output "aws_subnet" {
	value = "${aws_subnet.tf-subnet.id}"
}
# Define Security Group for subnet
resource "aws_security_group" "tf-securitygroup" {
  description = "Allow limited inbound external traffic"
  vpc_id      = "${aws_vpc.tf-vpc.id}"
  name        = "tf-demo-securitygroup"

ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }
 ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tf-demo-securitygroup"
  }
}
# Define SSH key pair for EC2 instance
resource "aws_key_pair" "key-demo" {
  key_name   = "key-demo"
  public_key = "${file("key-demo.pub")}"
}

#Define EC2 instance webserver
resource "aws_instance" "ec2testserver" {
    ami = "${var.ami}" 
    instance_type = "t2.micro"
  vpc_security_group_ids =  [ "${aws_security_group.tf-securitygroup.id}" ]
#    subnet_id = "${aws_subnet.tf-subnet.id}"
    key_name  = "${aws_key_pair.key-demo.key_name}"
    count         = 1
    associate_public_ip_address = true
        user_data = "${file("install-httpd.sh")}"
      tags = {
      Name              = "ec2testserver"
      Project           = "demo project"
    }
}

output "instance_id_list"     { value = ["${aws_instance.ec2testserver.*.id}"] }
output "test"  { value = ["welcome"]}
output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.ec2testserver.*.public_ip
}