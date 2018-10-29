variable "aws_region" {}
variable "vpc_cidr" {}
variable "pub_sub" {}
variable "priv_sub" {}
variable "ami_linux" {}
variable "ami_windows" {}
variable "instance_size" {}
variable "key_name" {}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_vpc" "main" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "main"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.pub_sub}"
  availability_zone = "us-west-1a"

  tags {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "${var.priv_sub}"
  availability_zone = "us-west-1b"

  tags {
    Name = "private_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "vpc_igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "public_route"
  }
}

resource "aws_route_table_association" "public_route_table" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_route.id}"
}

resource "aws_security_group" "sg_linux" {
  name = "vpc_linux"
  description = "SSH"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "linux_subnet_sg"
  }
}

resource "aws_security_group" "sg_windows" {
  name = "vpc_windows"
  description = "RDP"

  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "windows_subnet_sg"
  }
}

resource "aws_instance" "ubuntu" {
  ami = "${var.ami_linux}"
  instance_type = "${var.instance_size}"
  subnet_id = "${aws_subnet.public_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_linux.id}"]
  associate_public_ip_address = true
  key_name = "${var.key_name}"

  tags {
    Name = "linux_server"
  }
}

resource "aws_instance" "windows" {
  ami = "${var.ami_windows}"
  instance_type = "${var.instance_size}"
  subnet_id = "${aws_subnet.public_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sg_windows.id}"]
  associate_public_ip_address = true
  key_name = "${var.key_name}"

  tags {
    Name = "Windows_server"
  }
}
