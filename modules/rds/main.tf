# Create MySQL RDS Instance
resource "aws_db_instance" "web_db" {
  instance_class              = "${var.db_instance}"
  engine                      = "mysql"
  engine_version              = "5.7"
  multi_az                    = true
  storage_type                = "gp2"
  allocated_storage           = 20
  name                        = "web-db"
  username                    = "foo"
  password                    = "foobarbaz"
  apply_immediately           = true
  backup_retention_period     = 3
  backup_window               = "10:30-11:30"
  db_subnet_group_name        = "${aws_db_subnet_group.web_db_subnet.name}"
  vpc_security_group_ids      = ["${aws_security_group.web_rds_sg.id}"]
  parameter_group_name        = "default.mysql5.7"
  allow_major_version_upgrade = true
  maintenance_window          = "Mon:00:00-Mon:03:00"
}

# Create RDS Subnet Group
resource "aws_db_subnet_group" "web_db_subnet" {
  name       = "web-db-subnet"
  subnet_ids = ["${var.rds_subnet1}", "${var.rds_subnet2}"]
}

# Create RDS Security Group
resource "aws_security_group" "web_rds_sg" {
  name   = "web_rds_sg"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
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
    Name        = "${var.environment}_web_rds_sg"
    Environment = "${var.environment}"
  }
}