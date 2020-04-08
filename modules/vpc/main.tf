# Query all avilable Availibility Zone
data "aws_availability_zones" "available" {
  state = "available"
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name        = "${var.environment}_vpc"
    Environment = "${var.environment}"
  }
}

# Create Internet Gateway and attached to VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name        = "${var.environment}_igw"
    Environment = "${var.environment}"
  }
}

# Create Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name        = "${var.environment}_public_route_table"
    Environment = "${var.environment}"
  }
}

# Create Private Route Table
resource "aws_default_route_table" "private_route_table" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"

  route {
    nat_gateway_id = "${aws_nat_gateway.my_natgw.id}"
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name        = "${var.environment}_private_route_table"
    Environment = "${var.environment}"
  }
}

# Create Public subnets
resource "aws_subnet" "public_subnet" {
  count             = 2
  cidr_block        = "${var.public_cidr[count.index]}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name        = "${var.environment}_public_subnet_${count.index + 1}"
    Environment = "${var.environment}"
  }
}

# Create Private subnets
resource "aws_subnet" "private_subnet" {
  count             = 2
  cidr_block        = "${var.private_cidr[count.index]}"
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags = {
    Name        = "${var.environment}_private_subnet_${count.index + 1}"
    Environment = "${var.environment}"
  }
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  count          = 2
  route_table_id = "${aws_route_table.public_route_table.id}"
  subnet_id      = "${aws_subnet.public_subnet.*.id[count.index]}"
  depends_on     = ["aws_route_table.public_route_table", "aws_subnet.public_subnet"]

}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_subnet_association" {
  count          = 2
  route_table_id = "${aws_default_route_table.private_route_table.id}"
  subnet_id      = "${aws_subnet.private_subnet.*.id[count.index]}"
  depends_on     = ["aws_default_route_table.private_route_table", "aws_subnet.private_subnet"]

}

# Create Security Group
resource "aws_security_group" "my_sg" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name        = "${var.environment}_sg"
    Environment = "${var.environment}"
  }
}

# Create Security group rules
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.my_sg.id}"
}

# All OutBound rules
resource "aws_security_group_rule" "all_outbound_rules" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.my_sg.id}"
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Create Elastic IP
resource "aws_eip" "my_eip" {
  vpc = true

  tags = {
    Name        = "${var.environment}_eip"
    Environment = "${var.environment}"
  }
}

# Create NAT Gateway
resource "aws_nat_gateway" "my_natgw" {
  allocation_id = "${aws_eip.my_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.0.id}"

  tags = {
    Name        = "${var.environment}_natgw"
    Environment = "${var.environment}"
  }
}
