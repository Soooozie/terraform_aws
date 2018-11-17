resource "aws_security_group" "sg_linux" {
  name = "vpc_linux"
  description = "Allow all"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "linux_subnet_sg"
  }
}
