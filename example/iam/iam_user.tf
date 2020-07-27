provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "mfauser1" {
  name = "mfauser1"
}

resource "aws_iam_access_key" "mfauser1" {
  user = aws_iam_user.mfauser1.name
}

output "aws_iam_smtp_password_v4" {
  value = aws_iam_access_key.mfauser1.ses_smtp_password_v4
}

