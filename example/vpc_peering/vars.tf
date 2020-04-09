variable "secondary_vpc_id" {
  default = "${aws_vpc.main.id}"
}

variable "primary_vpc_id" {
  value = "${aws_vpc.main.id}"
}

variable "primary_vpc1_route_table" {
  value = "{aws_route_table.public_route_table.id}"
}

variable "secondary_vpc2_route_table" {
  value = "{aws_route_table.public_route_table.id}"
}

variable "primary_cidr_block" {
  value = "${aws_vpc.primary_cidr_block.id}"
}

variable "secondary_cidr_block" {
  value = "${aws_vpc.secondary_cidr_block.id}"
}


