# Below output resource (public_subnet) is used as the input to elb and auto-scaling module.
output "public_subnet1" {
  value = "${element(aws_subnet.public_subnet.*.id, 1)}"
}

output "public_subnet2" {
  value = "${element(aws_subnet.public_subnet.*.id, 2)}"
}

# Below output resource (private_subnet) is used as the input to rds module.
output "private_subnet1" {
  value = "${element(aws_subnet.private_subnet.*.id, 1)}"
}

output "private_subnet2" {
  value = "${element(aws_subnet.private_subnet.*.id, 2)}"
}

# Below output resource (security_group, private_subnet) is used as the input to EC2 module.

output "security_group" {
  value = "${aws_security_group.my_sg.id}"
}

output "private_subnet" {
  value = "${aws_subnet.private_subnet.*.id}"
}

# Below output resource (vpc_id) is used as the input to ELB module.

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}