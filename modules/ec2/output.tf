# Below output resource (instance_id) is used as the input to elb module.
output "instance1_id" {
  value = "${element(aws_instance.ec2_instance.*.id, 1)}"
}

output "instance2_id" {
  value = "${element(aws_instance.ec2_instance.*.id, 2)}"
}


output "server_ip1" {
  value = "${join(",",aws_instance.ec2_instance.*.private_ip)}"
}

output "server_ip2" {
  value = "${join(",",aws_instance.ec2_instance.*.private_ip)}"
}


