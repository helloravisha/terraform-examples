provider "aws" {
  region = "us-east-2"  # Change this to your AWS region
}

# Define a map of AMIs for different regions
variable "amis" {
  default = {
    us-east-2 = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI for your region
    us-west-1 = "ami-0abcdef1234567890"
  }
}

# Define a list of security groups
variable "sg1" {
  default = ["sg-0a5cace1e29d16763", "sg-0c2a74331d7dc8dcc"]
}

variable "sg2" {
  default = ["sg-01340c9a5d497d0c0"]
}

# Get the selected AMI based on region
output "selected_ami" {
  value = lookup(var.amis, "us-east-2", "ami-default")
}

# Merge security groups using concat
output "merged_sg" {
  value = concat(var.sg1, var.sg2)
}

# Count the number of security groups
output "sg_count" {
  value = length(concat(var.sg1, var.sg2))
}

# Join security groups into a single string
output "sg_string" {
  value = join(", ", concat(var.sg1, var.sg2))
}


# Create an EC2 instance using the selected AMI and merged security groups
resource "aws_instance" "example" {
  ami           = lookup(var.amis, "us-east-2", "ami-default")
  instance_type = "t2.micro"
  
  vpc_security_group_ids = concat(var.sg1, var.sg2)

  tags = {
    Name = join("-", ["hello", "world"])
  }
}

