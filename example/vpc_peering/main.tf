# Create VPC Peering between Primary and Secondary VPCs
resource "aws_vpc_peering_connection" "main_vpc" {
  peer_vpc_id   = "${var.secondary_vpc_id.id}"
  vpc_id        = "${var.primary_vpc_id.id}"
  auto_accept   = true

  accepter {
      allow_remote_vpc_dns_resolution = true
  }

  requester {
      allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "VPC Peering between Primary and Secondary"
  }
}

# Create Route Tables
resource "aws_route" "primary_to_secondary" {
    route_table_id = "${var.primary_vpc1_route_table.id}"
    destination_cidr_block = "${var.secondary_cidr_block.id}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.main_vpc.id}"
  
}

resource "aws_route" "secondary_to_primary" {
    route_table_id = "${var.secondary_vpc2_route_table.id}"
    destination_cidr_block ="${var.primary_cidr_block.id}"
    vpc_peering_connection_id = "${aws_vpc_peering_connection.main_vpc.id}"   
  
}

# Create VPC Peering between Primary and Secondary VPC Regions
resource "aws_vpc_peering_connection" "main_vpc" {
  peer_vpc_id   = "${aws_vpc.secondary_vpc_id.id}"
  vpc_id        = "${aws_vpc.primary_vpc_id.id}"
  auto_accept   = true

  accepter {
      allow_remote_vpc_dns_resolution = true
  }

  requester {
      allow_remote_vpc_dns_resolution = true
  }

  tags = {
    Name = "VPC Peering between Primary and Secondary"
  }
}

resource "aws_vpc" "primary_vpc_id" {
  provider   = "aws.us-east-1"
  cidr_block = "10.1.0.0/16"
}

resource "aws_vpc" "secondary_vpc_id" {
  provider   = "aws.us-west-1"
  cidr_block = "10.2.0.0/16"
}