terraform {
  backend "s3" {
    bucket = "ravisha-terraform-state"  # Replace with your bucket name
    key    = "terraform/state.tfstate"
    region = "us-east-2"
    dynamodb_table = "my-terraform-lock"  # Table to use for state locking
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}

