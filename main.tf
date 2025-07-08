# Main Terraform configuration file
# This file contains the main configuration for your Terraform project

# Configure the Docker Provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# Variables
variable "environment" {
  description = "Environment to deploy (docker or scalingo)"
  type        = string
  default     = "docker"
  validation {
    condition     = contains(["docker", "scalingo"], var.environment)
    error_message = "Environment must be either 'docker' or 'scalingo'."
  }
}

variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true
}

variable "docker_host" {
  description = "Docker host URL"
  type        = string
  default     = "unix:///var/run/docker.sock"
}

# Providers
provider "docker" {
  host = var.docker_host
}

provider "github" {
  token = var.github_token
}

# Local variables
locals {
  project_name = "cicd-cours"
  app_name     = "react-form-app"
  blog_api_name = "blog-api"
  
  # Docker configuration
  docker_network_name = "${local.project_name}-network"
  mysql_container_name = "${local.project_name}-mysql"
  mongodb_container_name = "${local.project_name}-mongodb"
  frontend_container_name = "${local.project_name}-frontend"
  backend_container_name = "${local.project_name}-backend"
  blog_api_container_name = "${local.project_name}-blog-api"
  adminer_container_name = "${local.project_name}-adminer"
  
  # Scalingo configuration
  scalingo_region = "osc-fr1"
}

# Docker Environment
module "docker_environment" {
  count  = var.environment == "docker" ? 1 : 0
  source = "./modules/docker"
  
  project_name = local.project_name
  app_name     = local.app_name
  blog_api_name = local.blog_api_name
  
  # Container names
  mysql_container_name = local.mysql_container_name
  mongodb_container_name = local.mongodb_container_name
  frontend_container_name = local.frontend_container_name
  backend_container_name = local.backend_container_name
  blog_api_container_name = local.blog_api_container_name
  adminer_container_name = local.adminer_container_name
  
  # Network
  network_name = local.docker_network_name
  
  # Ports
  mysql_port     = 3306
  mongodb_port   = 27017
  frontend_port  = 3000
  backend_port   = 8000
  blog_api_port  = 3001
  adminer_port   = 8080
}

# Scalingo Environment (simplified - just for structure)
module "scalingo_environment" {
  count  = var.environment == "scalingo" ? 1 : 0
  source = "./modules/scalingo"
  
  project_name = local.project_name
  app_name     = local.app_name
  blog_api_name = local.blog_api_name
  region       = local.scalingo_region
  
  # GitHub integration
  github_token = var.github_token
}

# Outputs
output "environment" {
  description = "Current environment"
  value       = var.environment
}

output "docker_network_name" {
  description = "Docker network name"
  value       = var.environment == "docker" ? local.docker_network_name : null
}

output "scalingo_app_url" {
  description = "Scalingo app URL"
  value       = var.environment == "scalingo" ? module.scalingo_environment[0].app_url : null
}

output "scalingo_blog_api_url" {
  description = "Scalingo blog API URL"
  value       = var.environment == "scalingo" ? module.scalingo_environment[0].blog_api_url : null
}
