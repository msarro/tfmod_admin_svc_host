resource "aws_instance" "adminsvc" {
  count = "${var.count}"

  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"
  subnet_id     = "${element(var.subnet_id, count.index)}"

  vpc_security_group_ids = ["${var.security_groups}", "${aws_security_group.adminsvc.id}"]

  user_data = "${var.user_data}"

  tags {
    Name        = "adminsvc-${var.environment}-${count.index}"
    Environment = "${var.environment}"
  }
}

resource "aws_security_group" "adminsvc" {
  name        = "adminsvc-${var.environment}"
  description = "Allows ssh and http traffic into admin service hosts."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_adminsvc_ssh"
  }
}
