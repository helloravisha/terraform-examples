provider "aws" {
  region = "us-east-2"  # Choose your preferred AWS region
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Choose a valid AMI for your region
  instance_type = "t2.micro"
  key_name      = "my-ec2-key"  # The key name for the SSH key pair in AWS
  
  tags = {
    Name = "TerraformExample"
  }
}

# Provisioner to run commands remotely via SSH
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Choose a valid AMI for your region
  instance_type = "t2.micro"
  key_name      = "my-ec2-key"  # Use the same key name here

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"  # Default user for Ubuntu AMIs
      private_key = file("~/.ssh/my-ec2-key")  # Path to your private key
      host        = aws_instance.example.public_ip  # Use the public IP of the instance
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",  # Example command to install nginx
    ]
  }

  tags = {
    Name = "TerraformExample"
  }
}

