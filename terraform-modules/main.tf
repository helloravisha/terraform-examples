# main.tf

provider "aws" {
  region = "us-east-2"
}

module "ec2-instance" {
  source        = "./modules/ec2-instance"
  ami_id        = "ami-0c55b159cbfafe1f0"  # Example AMI ID
  instance_type = "t2.micro"
  subnet_id     = "subnet-0f38c180e19c7dbff"
  instance_name = "example-instance"
}

