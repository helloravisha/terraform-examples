# Terraform Examples Repository

This repository contains a collection of practical Terraform examples demonstrating various features.



### 1. `terraform-datasources`
Examples demonstrating how to use Terraform **data sources** to fetch and reference information defined outside the Terraform configuration (e.g., AWS AMIs, existing infrastructure).

- ✅ Lookup resources in external systems
- ✅ Use data sources with modules and locals

---

### 2. `terraform-functions`
Showcases usage of **built-in Terraform functions** such as `join`, `lookup`, `element`, `concat`, etc.

- ✅ Explore string, numeric, and collection functions
- ✅ Demonstrates interpolation and dynamic expressions

---

### 3. `terraform-helloworld`
A simple "Hello World"-style example to bootstrap Terraform learning.

- ✅ Configure a basic provider (like AWS)
- ✅ Create a basic resource (e.g., EC2 or S3)

---

### 4. `terraform-loops`
Examples on using **`for_each`**, **`count`**, and **`for` loops** in Terraform to dynamically create resources.

- ✅ `for_each` with maps and sets
- ✅ `count` for dynamic scaling
- ✅ Looping over complex structures

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

### 7. `terraform-secret`
Demonstrates best practices for **handling secrets** in Terraform using:
- Environment variables
- Sensitive variables
- External secret managers (e.g., AWS Secrets Manager)

- ✅ Avoid committing secrets to version control
- ✅ Use Terraform’s `sensitive = true` flag

---

### 8. `terraform-state-management`
Examples related to **Terraform state** operations:
- Backends
- Remote state
- Locking and state file security

- ✅ Configure remote backend (e.g., S3 + DynamoDB)


---

### 9. `terraform-workspaces`
Covers **Terraform workspaces**, which are used to manage multiple environments (e.g., dev, staging, prod) from the same configuration.

- ✅ Create and switch workspaces
- ✅ Isolate resources by environment
- ✅ Workspace-aware variables

---

##  Getting Started

Each folder contains its own `main.tf`, `variables.tf`, and `outputs.tf` (where relevant). To get started with any example:

```bash
cd terraform-helloworld
terraform init
terraform plan
terraform apply
