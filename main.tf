provider "aws" {
    region = "us-east-1"
}

variable "name" {
    description = "test-deploy"
}

resource "aws_instance" "aws-demo" {
    ami = "ami-042e8287309f5df03"
    instance_type = "t2.micro"
    key_name = "admin"

    tags = {
            Name = "aws-test"
    }
}