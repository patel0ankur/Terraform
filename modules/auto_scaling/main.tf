# Create Launch Confiuration
resource "aws_launch_configuration" "web_launch_config" {

  image_id        = "${var.ami}"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.web_as_sg.id}"]

  user_data = <<-EOF
              #!/bin/bash
              yum install update -y 
              sudo /usr/sbin/useradd -c "Admin User" -d /home/admin -g root admin
              yum install nginx -y 
              yum -y install chrony
              systemctl enable chronyd
              systemctl start chronyd

              mkfs -t ext4 /dev/xvdb
              mkdir /mnt/disk_b
              mount /dev/xvdb /mnt/disk_b
              echo '/dev/xvdb /mnt/disk_b ext4 defaults,nofail,noatime  0  0' >> /etc/fstab
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

# Create Security Group
resource "aws_security_group" "web_as_sg" {
  name   = "web_asg_sg"
  vpc_id = "${var.vpc_id}"

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
    Name        = "${var.environment}_web_as_sg"
    Environment = "${var.environment}"
  }
}

# Create Auto Scaling Group 
resource "aws_autoscaling_group" "web_as_group" {
  name                 = "web_as_group"
  launch_configuration = "${aws_launch_configuration.web_launch_config.name}"
  vpc_zone_identifier  = ["${var.public_subnet1}", "${var.public_subnet2}"]
  target_group_arns    = ["${var.target_group_arn}"]
  min_size             = 2
  max_size             = 4

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "web_as_group"
    propagate_at_launch = true
  }
}