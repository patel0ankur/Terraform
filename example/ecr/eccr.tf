terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_ecr_repository" "ets_ecr" {
  name                 = "ets_ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}