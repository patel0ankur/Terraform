variable "public_key" {
  description = "ec2_keypair"
}

variable "instance_type" {
  description = "Instance Type"
}

variable "security_group" {
  description = "Security Group"
}

variable "subnets" {
  type = "list"
}

variable "environment" {
  description = "Environment Name"
}

