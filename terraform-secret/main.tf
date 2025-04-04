provider "aws" {
  region = "us-east-2"
}

# Create a secret in AWS Secrets Manager
resource "aws_secretsmanager_secret" "example" {
  name        = "example_secret"
  description = "Example secret for Terraform"
}

# Store the secret value (username and password)
resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = aws_secretsmanager_secret.example.id
  secret_string = jsonencode({
    username = "example_user"
    password = "example_password"
  })
}

# Retrieve the secret metadata (ARN, name, etc.)
data "aws_secretsmanager_secret" "example" {
  arn = aws_secretsmanager_secret.example.arn
}

# Retrieve the latest secret version (this will refer to "AWSCURRENT")
data "aws_secretsmanager_secret_version" "example" {
  secret_id = aws_secretsmanager_secret.example.id
}

# Output the secret metadata (this will display ARN, name, etc.)
output "secret_metadata" {
  value = data.aws_secretsmanager_secret.example
}

# Output the secret value (username and password, json-decoded)
output "secret_value" {
  value     = jsondecode(data.aws_secretsmanager_secret_version.example.secret_string)
  sensitive = true  # Mark this output as sensitive
}

