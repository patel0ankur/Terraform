terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-1"
}

variable "function_name" {
  default = "hellopythonfunction"
  description = "Function Name"
}

#data "archive_file" "welcome" {
#  type        = "zip"
#  source_file = "welcome.py"
#  output_path = "helloworld.zip"
#}


resource "aws_lambda_function" "lambda_s3_python" {
#  filename      = "helloworld.zip"
  s3_bucket = "githubbkp"
  s3_key = "helloworld.zip"
  function_name = var.function_name
  role          = aws_iam_role.lambda_iam_role.arn
  handler       = "welcome.hello"


  source_code_hash = filebase64sha256("helloworld.zip")

  runtime = "python3.8"

  tags = {
    Name = var.function_name
  }
}