provider "aws" {
  region = "us-east-2"
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create multiple subnets dynamically (using count)
variable "subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

resource "aws_subnet" "my_subnet" {
  count      = length(var.subnet_cidrs)
  vpc_id     = aws_vpc.my_vpc.id  # Ensure the subnet is in the same VPC
  cidr_block = var.subnet_cidrs[count.index]
}

# Create multiple security groups (using for_each)
variable "services" {
  default = {
    web  = 80
    ssh  = 22
    api  = 8080
  }
}

resource "aws_security_group" "my_sg" {
  for_each = var.services

  name        = "customsg-${each.key}"
  description = "Security group for ${each.key}"
  vpc_id      = aws_vpc.my_vpc.id  # Ensure security group is in the same VPC

  ingress {
    from_port   = each.value
    to_port     = each.value
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Filter and create only 'prod' instances (using for_each with if)
variable "instances" {
  default = {
    dev  = "t2.micro"
    prod = "t3.large"
  }
}

resource "aws_instance" "filtered" {
  for_each = { for k, v in var.instances : k => v if k == "prod" }

  ami                    = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID
  instance_type          = each.value
  vpc_security_group_ids = [aws_security_group.my_sg["api"].id]  # Use correct security group

  subnet_id = aws_subnet.my_subnet[0].id  # Assigning to the first subnet in the list, can change as per your requirement

  tags = {
    Name = each.key
  }
}

# Generate all environment-region combinations (Nested `for`)
variable "envs" {
  default = ["dev", "prod"]
}

variable "regions" {
  default = ["us-east-2", "us-west-2"]
}

output "env_region_pairs" {
  value = [for env in var.envs : [for region in var.regions : "${env}-${region}"]]
}

# Convert list to a map using `for`
variable "subnet_names" {
  default = ["subnet-1", "subnet-2", "subnet-3"]
}

output "subnet_map" {
  value = { for idx, subnet in var.subnet_names : idx => subnet }
}

