provider "aws" {
  region  = "${var.region}"
}

resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "dev_vpc"
}
}

resource "aws_subnet" "dev_subnet" {
  cidr_block        = "${cidrsubnet(aws_vpc.dev_vpc.cidr_block, 3, 1)}"
  vpc_id            = "${aws_vpc.dev_vpc.id}"
  availability_zone = "${var.zone}"
}

resource "aws_security_group" "dev_ingress_all" {
  name   = "allow-all-sg"
  vpc_id = "${aws_vpc.dev_vpc.id}"
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "dev_ec2_instance" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  key_name        = "${var.ami_key_name}"
  subnet_id       = "${aws_subnet.dev_subnet.id}"
  security_groups = [
    "${aws_security_group.dev_ingress_all.id}"
  ]
  tags = {
    name = "${var.ami_key_name}"
  }
}

resource "aws_eip" "dev_elastic_ip" {
  instance = "${aws_instance.dev_ec2_instance.id}"
  vpc      = true
}

resource "aws_internet_gateway" "dev_env_gw" {
  vpc_id = "${aws_vpc.dev_vpc.id}"
  tags = {
    name = "dev_env_gw"
  }
}

resource "aws_route_table" "dev_route_table" {
  vpc_id = "${aws_vpc.dev_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev_env_gw.id}"
  }
  tags = {
    name = "dev_route_table"
  }
}

resource "aws_route_table_association" "dev_subnet_association" {
  subnet_id      = "${aws_subnet.dev_subnet.id}"
  route_table_id = "${aws_route_table.dev_route_table.id}"
}
