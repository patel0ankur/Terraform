variable "ami" {
  type = map(string)
  default = {
    "us-east-1" = "ami-04169656fea786776"
    "us-west-1" = "ami-006fce2a9625b177f"
  }
}

variable "instance_type" {
  default = "t2.nano"
}

variable "aws_region" {
  default = "us-west-1"
}
