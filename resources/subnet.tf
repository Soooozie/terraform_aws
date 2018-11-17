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
  availability_zone = "us-west-1a"

  tags {
    Name = "private_subnet"
  }
}
