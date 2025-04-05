
# Terraform Learning Examples

## Quickstart

```bash
cd terraform-helloworld
terraform init
terraform plan
terraform apply
```

---

### 1. `terraform-helloworld`
A simple "Hello World"-style example to bootstrap Terraform learning.

- ✅ Configure a basic provider (like AWS)
- ✅ Create a basic resource (e.g., EC2 or S3)

---

### 2. `terraform-loops`
Examples on using **`for_each`**, **`count`**, and **`for` loops** in Terraform to dynamically create resources.

- ✅ `for_each` with maps and sets  
- ✅ `count` for dynamic scaling  
- ✅ Looping over complex structures

---

### 3. `terraform-functions`
Showcases usage of **built-in Terraform functions** such as `join`, `lookup`, `element`, `concat`, etc.

- ✅ Explore string, numeric, and collection functions  
---

### 4. `terraform-datasources` - "helps to fetch data from external resource ( Eg VPC, Security group ) or  invoking an API for Data "
- ✅ Lookup resources in external systems
- ✅ Invoking API
```bash
data "http" "example" {
  url = "https://api.example.com/data"
}

output "api_response" {
  value = data.http.example.body
}
``` 
- ✅ querying s3
```bash
data "aws_s3_bucket" "existing_bucket" {
  bucket = "my-existing-bucket"
}

output "bucket_region" {
  value = data.aws_s3_bucket.existing_bucket.region
}

``` 
- ✅ querying security group
```bash
data "aws_security_group" "existing_sg" {
  name = "my-security-group"
}

output "security_group_id" {
  value = data.aws_security_group.existing_sg.id
}

```

---

### 5. `terraform-modules` - "helps us to oraganiize infrasturecture resources and reuse them as required "

- ✅ Create and consume local modules  
- ✅ invoking ec2-instance module, located in the modules folder, we can call the same module elsewhere with different inputs.
```bash
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

```  
---

### 6. `terraform-provisioner`- "To execute sonmething locally where terraform  running or remotley on the reosurce "
Eg :  installing software, running commands, or uploading files. 
While useful for basic tasks, it's better to use dedicated configuration management tools (like Ansible or Chef) for more complex provisioning, as Terraform provisioners are intended for quick, one-time actions.

Shows how to use **provisioners** like `remote-exec` and `file` to perform actions on a resource after it's created.

- ✅ Use inline shell scripts for post-creation setup  
- ✅ Upload files and configure remote machines
```bash
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
``` 

---

### 7. `terraform-secret` - "To create , store and read secret using external secret manager from AWS"

- creating secret - resource "aws_secretsmanager_secret"
```bash
resource "aws_secretsmanager_secret" "example" {
  name        = "example_secret"
  description = "Example secret for Terraform"
}

```  
- adding values to secret
```bash
# Store the secret value (username and password)
resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = jsonencode({
    username = "example_user"
    password = "example_password"
  })
}
```  
- read the data
```bash
# read  the secret value (username and password)
data "aws_secretsmanager_secret" "example" {
  arn = aws_secretsmanager_secret.example.arn
}
```   
- ✅ Avoid committing secrets to version control  
- ✅ Use Terraform’s `sensitive = true` flag
- ✅ Environment variables can also be used for secret input

---

### 8. `terraform-state-management` – "Store the infrastructure state either locally or remotely"
State management in Terraform is necessary to track the current infrastructure's configuration, enabling Terraform to determine what changes are required to reach the desired state during execution.
  ```bash
  terraform {
    backend "s3" {
      bucket = "ravisha-terraform-state"  # Replace with your bucket name
      key    = "terraform/state.tfstate"
      region = "us-east-2"
      dynamodb_table = "my-terraform-lock"  # Table to use for state locking
    }
  }
```


- ✅ Configure remote backend (e.g., S3 + DynamoDB)

---

### 9. `terraform-workspaces` – "Same code, different environments or states."

Used to manage multiple environments (e.g., `dev`, `staging`, `prod`) using the same configuration. Each workspace has its own `.tfstate` file behind the scenes, keeping environment states isolated.

---

#### Common Workspace Commands

- **Create and switch to a new workspace**
  ```bash
  terraform workspace new dev
  ```

- **List all workspaces**
  ```bash
  terraform workspace list
  ```

- **Show the current workspace**
  ```bash
  terraform workspace show
  ```

---

#### ⚠️ When *Not* to Use Workspaces

Terraform workspaces are **not ideal** for managing **completely different infrastructure setups**. Use separate configuration directories or backends instead.

**Examples:**

- `prod` is in one AWS region and `dev` is in another  
- `prod` uses RDS, but `dev` uses SQLite

---





