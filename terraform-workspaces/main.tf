resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = terraform.workspace == "dev" ? "t2.micro" : "t2.small"

  tags = {
    Name        = "example-server-${terraform.workspace}"
    Environment = terraform.workspace
  }
}

