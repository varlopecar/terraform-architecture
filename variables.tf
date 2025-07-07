# Variables file
# Define input variables for your Terraform configuration

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "nginx:latest"
}

variable "scalingo_token" {
  description = "tk-us-aG73AESgVE2gO6blaT-lqGb7nRL16XqWx0D7sQiFAa5B31uQ"
  type        = string
  sensitive   = true
}