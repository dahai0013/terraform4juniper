#AWS access and securty key
# 1- create an VPC
# 1a- create an Internet Gateway
# 1b- create an Route in the RT
# 1c- create Security Groups
# 2- create subnet
# 3- Create an Key pair to access the VM
# 4- create an instance

# define variables and point to terraform.tfvars
variable "access_key" {}
variable "secret_key" {}
variable "region" { default = "eu-west" }
variable pri_sub1 { default = "10.1.1.0/24" }
#variable pri_sub2 { default = "10.1.2.0/24" }


#AWS access and secret key to access AWS
provider "aws" {
        access_key = "${var.access_key}"
        secret_key = "${var.secret_key}"
        region = "${var.region}"
}

# 1- create an VPC in aws
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags {
    Name = "ixVPC"
  }
}

# 1a- create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "main_gw"
  }
}

# 1b- create an Route in the RT
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

# 1c- create Security Groups
resource "aws_security_group" "allow_ssh" {
  name = "allow_inbound_SSH"
  description = "Allow inbound SSH traffic from any IP@"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    #prefix_list_ids = ["pl-12c4e678"]
  }
  tags {
    Name = "Allow SSH"
    }
}

# 2- create subnet
resource "aws_subnet" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  cidr_block = "${var.pri_sub1}"
  tags {
    #Name = "${var.name}-private"
    Name = "ixVPC-private"
  }
}

#3- Create an Key pair to access the VM
#resource "aws_key_pair" "admin_key" {
#  key_name   = "admin_key"
#  public_key = "ssh-rsa AAAAB3[…]"
#}

# 4- create an instance
resource "aws_instance" "ubuntu1" {
        #ubuntu AMI
        #ami = "ami-e0bc5987"
        #instance_type = "t2.micro"
        #AWS AMI
        ami = "ami-403e2524"
        instance_type = "t2.nano"
        key_name = "terraformkeypair2"
        subnet_id = "${aws_subnet.private.id}"
        #security_groups= ["TerraformsSecurityGroup"]
        security_groups = ["${aws_security_group.allow_ssh.id}"]
        associate_public_ip_address = true
        tags {
         Name = "Ubuntu1-instance"
        }
}
