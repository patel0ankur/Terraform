terraform {
  required_version = ">= 0.12"
}

resource "aws_iam_role_policy" "lambda_iam_policy" {
  name = "lambda_iam_policy"
  role = aws_iam_role.lambda_iam_role.id

  policy = "${file("lambda_policy.json")}"


}

resource "aws_iam_role" "lambda_iam_role" {
  name = "lambda_iam_role"

  assume_role_policy = "${file("lambda_iam_role.json")}"
}