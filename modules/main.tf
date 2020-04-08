# AWS Provider
provider "aws" {
  region = "${var.region}"
}

# Variables for VPC

module "vpc" {
  source       = "./vpc"
  environment  = "dev"
  vpc_cidr     = "10.74.0.0/16"
  public_cidr  = ["10.74.1.0/24", "10.74.2.0/24"]
  private_cidr = ["10.74.3.0/24", "10.74.4.0/24"]
}

# Variables for EC2
module "ec2" {
  source         = "./ec2"
  environment    = "dev"
  public_key     = "C:\\Users\\patelax\\Documents\\GitHub\\terraform\\modules\\ec2\\id_rsa.pub"
  instance_type  = "t2.micro"
  security_group = "${module.vpc.security_group}"
  subnets        = "${module.vpc.private_subnet}"
}
