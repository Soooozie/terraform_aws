resource "aws_instance" "centos" {
  count = "${var.instance_count}"
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

output "linux_instance" {
  value = "${aws_instance.centos.*.id}"
}
