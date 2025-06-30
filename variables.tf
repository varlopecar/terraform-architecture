# Variables file
# Define input variables for your Terraform configuration

variable "container_name" {
  description = "Name of the container"
  type        = string
  default     = "nginx:latest"
}