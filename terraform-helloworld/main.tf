provider "aws" {
  region = var.aws_region  # Change this to your desired AWS region
}

resource "aws_instance" "hello_world" {
  ami           = "ami-036841078a4b68e14"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"                # Ensure you use an eligible instance type for your AWS free tier

  tags = {
    Name = "HelloWorld"
  }
}

