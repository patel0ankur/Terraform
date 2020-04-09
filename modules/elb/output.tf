output "elb_dns_name" {
  value = "${aws_lb.web_elb.dns_name}"
}
# Below output resource (elb target group) is used as the input to auto-scaling module.
output "elb_target_group_arn" {
  value = "${aws_lb_target_group.web_target_group.arn}"
}