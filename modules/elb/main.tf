# Create Target Group
resource "aws_lb_target_group" "web_target_group" {

    name = "web_target_group"
    port = "80"
    protocol = "HTTP"
    target_type = "instance"
    vpc_id = "${var.vpc_id}"

    health_check {
        protocol = "HTTP"
        path     = "/"
        healthy_threshold   = 5
        unhealthy_threshold = 2
        timeout             = 5
        interval            = 10
    }
}

# Reginster Targets (Instances) to Target group
resource "aws_lb_target_group_attachment" "elb_targetgroup_instance1" {
  target_group_arn = "${aws_lb_target_group.web_target_group.arn}"
  target_id        = "${var.instance1_id.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "elb_targetgroup_instance2" {
  target_group_arn = "${aws_lb_target_group.web_target_group.arn}"
  target_id        = "${var.instance2_id.id}"
  port             = 80
}

# Create Load Balancer
resource "aws_lb" "web_elb" {
  name                       = "web_elb"
  internal                   = false
  load_balancer_type         = "application"
  ip_address_type            = "ipv4"
  security_groups            = ["${aws_security_group.elb_sg.id}"]
  subnets                    = ["${var.public_subnet1}", "${var.public_subnet2}"]
  enable_deletion_protection = true

  tags = {
    Name = "${var.environment}_web_elb"
    Environment = "${var.environment}"
  }
}

# Create Security Group for ELB
resource "aws_security_group" "web_elb_sg" {
  name        = "web_elb_sg"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}_web_elb_sg"
    Environment = "${var.environment}"
  }
}

# Create ELB Listener
resource "aws_lb_listener" "web_end_listner" {
  load_balancer_arn = "${aws_lb.web_elb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.web_target_group.arn}"
  }
}