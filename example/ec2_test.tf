provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "ec2_sg" {
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_instance" {
  count                  = 2
  ami                    = "ami-bd32cac7"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.ec2_sg.id}"]
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "20"
    delete_on_termination = true
  }


  tags = {
    name = "webserver"
  }
}


