provider "aws" {
  region = "${var.region}"
}

resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags {
    Name   = "myvpc"
    region = "US-east-1"
  }
}

# aws_vpc.myvpc.id (resource.name.attribute(expoted from VPC))

resource "aws_subnet" "public_subnet" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.public_subnet}"

  tags {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = "${aws_vpc.myvpc.id}"
  cidr_block = "${var.private_subnet}"

  tags = {
    Name = "private_subnet"
  }
}
