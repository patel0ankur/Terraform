variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "190.160.0.0/16"
}

variable "public_subnet" {
  default = "190.160.1.0/24"
}

variable "private_subnet" {
  default = "190.160.2.0/24"
}
