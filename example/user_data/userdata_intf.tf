terraform {
    required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.27"
      }

    }
  required_version = ">= 0.14.9"
}



provider "aws" {
	region = "us-east-1"
    profile = "default"
}


resource "aws_instance" "my-instance" {
	ami = "ami-04169656fea786776"
	instance_type = "t2.nano"
	user_data = <<-EOF
		#! /bin/bash
                sudo apt-get update
		sudo apt-get install -y apache2
		sudo systemctl start apache2
		sudo systemctl enable apache2
		echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
        EOF
	tags = {
		Name = "Terraform"	
		Batch = "5AM"
	}
}