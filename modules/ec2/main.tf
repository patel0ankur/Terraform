# Query all avilable Availibility Zone
data "aws_availability_zones" "available" {
  state = "available"
}

#Search AMI
data "aws_ami" "centos" {
  owners = ["679593333241"]
  most_recent = true

  filter {
    name = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

}

# Create Key Pair
resource "aws_key_pair" "ec2_key" {
  key_name = "ec2_server_key"
  public_key = "${file(var.public_key)}"

}

# Create Template File
data "template_file" "init" {
  template = "${file("${path.module}/data.tpl")}"
}

# Create EC2 Instances
resource "aws_instance" "ec2_instance" {
  count                  = 2
  ami                    = "${data.aws_ami.centos.id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.ec2_key.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${element(var.subnets, count.index )}"
  user_data              = "${data.template_file.init.rendered}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }

  tags = {
    Name = "${var.environment}_web_instance_${count.index + 1}"
    Environment = "${var.environment}"
  }
}

# Create EBS Volume
resource "aws_ebs_volume" "ec2_ebs" {
  count             = 2
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  size              = 1
  type              = "gp2"

  tags = {
    Name = "${var.environment}_ec2_ebs_${count.index + 1}"
    Instance = "${aws_instance.ec2_instance.*.id[count.index]}"
    Environment = "${var.environment}"
  }
}

# Attach EBS Volume
resource "aws_volume_attachment" "ebs_vol_attach" {
  count        = 2
  device_name  = "/dev/xvdb"
  instance_id  = "${aws_instance.ec2_instance.*.id[count.index]}"
  volume_id    = "${aws_ebs_volume.ec2_ebs.*.id[count.index]}"
  force_detach = true
}
