variable "vpc_cidr" {
  description = "VPC CIDR"
}

variable "public_cidr" {
  description = "Public CIDR"
  type        = "list"
}

variable "private_cidr" {
  description = "Private CIDR"
  type        = "list"
}

variable "environment" {
  description = "Environment Name"
}
