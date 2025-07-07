output "network_id" {
  description = "ID of the Docker network"
  value       = docker_network.app_network.id
}

output "network_name" {
  description = "Name of the Docker network"
  value       = docker_network.app_network.name
}

output "mysql_container_id" {
  description = "ID of the MySQL container"
  value       = docker_container.mysql.id
}

output "mongodb_container_id" {
  description = "ID of the MongoDB container"
  value       = docker_container.mongodb.id
}

output "backend_container_id" {
  description = "ID of the backend container"
  value       = docker_container.backend.id
}

output "blog_api_container_id" {
  description = "ID of the blog API container"
  value       = docker_container.blog_api.id
}

output "frontend_container_id" {
  description = "ID of the frontend container"
  value       = docker_container.frontend.id
}

output "adminer_container_id" {
  description = "ID of the Adminer container"
  value       = docker_container.adminer.id
}

output "frontend_url" {
  description = "URL to access the frontend"
  value       = "http://localhost:${var.frontend_port}"
}

output "backend_url" {
  description = "URL to access the backend API"
  value       = "http://localhost:${var.backend_port}"
}

output "blog_api_url" {
  description = "URL to access the blog API"
  value       = "http://localhost:${var.blog_api_port}"
}

output "adminer_url" {
  description = "URL to access Adminer"
  value       = "http://localhost:${var.adminer_port}"
}

output "mysql_connection_string" {
  description = "MySQL connection string"
  value       = "mysql://app_user:app_password@localhost:${var.mysql_port}/react_form_db"
  sensitive   = true
}

output "mongodb_connection_string" {
  description = "MongoDB connection string"
  value       = "mongodb://admin:adminpassword@localhost:${var.mongodb_port}/blog_db?authSource=admin"
  sensitive   = true
} 