# Main Terraform configuration file
# This file contains the main configuration for your Terraform project

# Configure the Docker Provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Configure the Docker Provider
provider "docker" {

}

# Example resource - you can remove or modify this
resource "docker_container" "nginx" {
  name  = var.container_name
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8080
  }
}