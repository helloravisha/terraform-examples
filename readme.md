
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
- ✅ Demonstrates interpolation and dynamic expressions

---

### 4. `terraform-datasources`
Examples demonstrating how to use Terraform **data sources** to fetch and reference information defined outside the Terraform configuration (e.g., AWS AMIs, existing infrastructure).

- ✅ Lookup resources in external systems  
- ✅ Use data sources with modules and locals

---

### 5. `terraform-modules`
Demonstrates how to organize and reuse code via **Terraform modules**.

- ✅ Create and consume local modules  
- ✅ Pass variables and outputs between modules  
- ✅ Showcase module best practices

---

### 6. `terraform-provisioner`
Shows how to use **provisioners** like `remote-exec` and `file` to perform actions on a resource after it's created.

- ✅ Use inline shell scripts for post-creation setup  
- ✅ Upload files and configure remote machines

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





