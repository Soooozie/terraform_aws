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
