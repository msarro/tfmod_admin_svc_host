output "ips" {
  value = "${join(",", aws_instance.adminsvc.*.public_ip)}"
}

output "securitygroup" {
  value = "${aws_security_group.adminsvc.id}"
}