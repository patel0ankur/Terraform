variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "190.160.0.0/16"
}

#variable "public_subnet" {
#  default = "190.160.1.0/24"
#}

#variable "private_subnet" {
#  default = "190.160.2.0/24"
#}

variable "private_subnet" {
  type    = "list"
  default = ["190.160.1.0/24", "190.160.2.0/24"]
}

data "aws_availability_zones" "azs_private" {}

#List to provide Avialability zones


#variable "availability_zones_private" {
#  type    = "list"
#  default = ["us-east-1a", "us-east-1b"]
#}


#variable "public_subnet" {
#  type    = "list"
#  default = ["190.160.3.0/24", "190.160.4.0/24"]
#}


#variable "availability_zones_public" {
#  type    = "list"
#  default = ["us-east-1c", "us-east-1d"]
#}


#declare the availability zones

