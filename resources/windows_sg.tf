resource "aws_security_group" "sg_windows" {
  name = "vpc_windows"
  description = "Allow all"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "windows_subnet_sg"
  }
}
