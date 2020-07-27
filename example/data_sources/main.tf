provider "aws" {
  region = var.region
}

resource "aws_vpc" "myvpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name   = "myvpc"
    region = "US-east-1"
  }
}

# aws_vpc.myvpc.id (resource.logicalname.attribute(expoted from VPC))

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.myvpc.id

  # Count availability_zones
  count             = length(data.aws_availability_zones.azs_private.names)
  availability_zone = element(data.aws_availability_zones.azs_private.names, count.index)

  # Loop subnet cidr list one by one
  cidr_block = element(var.private_subnet, count.index)

  tags = {
    Name = "private_subnet-${count.index + 1}"
  }
}

#resource "aws_subnet" "public_subnet" {
# Count availability_zones
#  count  = "${length(var.availability_zones_public)}"
#  vpc_id = "${aws_vpc.myvpc.id}"
# Loop subnet cidr list one by one
#  cidr_block = "${element(var.public_subnet,count.index)}"
#  tags {
#    Name = "public_subnet-${count.index+1}"
#  }
#}
