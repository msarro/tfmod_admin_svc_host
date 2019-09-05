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
  description = "Allows SSH traffic into bastion hosts."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.cidr_blocks}"
  }

  tags {
    Name = "allow_bastion_ssh"
  }
}
