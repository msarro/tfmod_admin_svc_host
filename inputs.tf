variable "ami" {
  description = "The ami to be used for the admin service hosts"
}

variable "instance_type" {
  description = "The instance type to be used for this host"
  default     = "t2.nano"
}

variable "key_name" {
  description = "The SSH keypair to be used for access"
}

variable "subnet_id" {
  description = "The ID of the subnet in which this host should be located"
  type        = "list"
}

variable "environment" {
  description = "The name of the environment in which this host will be located."
}

variable "count" {
  description = "The number of admin hosts to be created"
  default = "1"
}

variable "vpc_id" {
  description = "VPC for the admin service security group"
}

variable "cidr_blocks" {
  description = "CIDR blocks for security group"
  type        = "list"
}

variable "security_groups" {
  description = "Security groups for Admin service host"
  type        = "list"
}

variable "user_data" {
  description = "User data for Admin service instantiation"

  default = <<EOF
#!/bin/bash
apt-get update
apt-get -y upgrade
EOF
}
