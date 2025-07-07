variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "app_name" {
  description = "Name of the main application"
  type        = string
}

variable "blog_api_name" {
  description = "Name of the blog API"
  type        = string
}

variable "region" {
  description = "Scalingo region"
  type        = string
  default     = "osc-fr1"
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
} 