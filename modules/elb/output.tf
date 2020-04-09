output "elb_dns_name" {
  value = "${aws_lb.web_elb.dns_name}"
}

output "elb_target_group_arn" {
  value = "${aws_lb_target_group.web_target_group.arn}"
}