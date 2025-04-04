provider "aws" {
  region = "us-east-2"  # Specify the AWS region
}

# Define the data source to find the latest Amazon Linux AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]  # Amazon is the owner of the official AMIs
  
  # Correct use of filter (singular)
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]  # Filter for Amazon Linux 2 AMIs
  }
}

# Launch an EC2 instance using the AMI retrieved from the data source
resource "aws_instance" "example" {
  ami           = data.aws_ami.latest_amazon_linux.id  # Use the AMI ID from the data source
  instance_type = "t2.micro"  # Choose the instance type

  tags = {
    Name = "ExampleInstance"
  }
}

