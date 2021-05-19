
resource "aws_instance" "my-instance" {
  count         = 1
  ami           = lookup(var.ami, var.aws_region)
  instance_type = var.instance_type

  tags = {
    Name  = "Terraform"
    Batch = "5AM"
  }
}