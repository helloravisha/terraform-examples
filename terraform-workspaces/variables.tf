variable "ami"{
   description = "AMI ID for Ec2 instance"
}

variable "instance_type" {
     description = "instance type for ec2 instance" 
     default ="t2.micro"
}


