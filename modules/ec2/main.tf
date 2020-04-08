provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_ami" "centos" {
  owners = ["679593333241"]
  most_recent = true

  filter {
    name = "name"
    valuse = ["Red Hat Enterprise Linux *"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

}
