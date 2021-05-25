terraform {
  required_version = ">= 0.12"
}

resource "aws_s3_bucket" "helloworldets10ankur" {
  bucket = "helloworldets10ankur"
  acl = "private"
  versioning {
    enabled = true
  }


  tags = {
    Name = "hello_world_ets"
  }

}