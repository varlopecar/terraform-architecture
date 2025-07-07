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

variable "network_name" {
  description = "Name of the Docker network"
  type        = string
}

variable "mysql_container_name" {
  description = "Name of the MySQL container"
  type        = string
}

variable "mongodb_container_name" {
  description = "Name of the MongoDB container"
  type        = string
}

variable "frontend_container_name" {
  description = "Name of the frontend container"
  type        = string
}

variable "backend_container_name" {
  description = "Name of the backend container"
  type        = string
}

variable "blog_api_container_name" {
  description = "Name of the blog API container"
  type        = string
}

variable "adminer_container_name" {
  description = "Name of the Adminer container"
  type        = string
}

variable "mysql_port" {
  description = "External port for MySQL"
  type        = number
  default     = 3306
}

variable "mongodb_port" {
  description = "External port for MongoDB"
  type        = number
  default     = 27017
}

variable "frontend_port" {
  description = "External port for frontend"
  type        = number
  default     = 3000
}

variable "backend_port" {
  description = "External port for backend"
  type        = number
  default     = 8000
}

variable "blog_api_port" {
  description = "External port for blog API"
  type        = number
  default     = 3001
}

variable "adminer_port" {
  description = "External port for Adminer"
  type        = number
  default     = 8080
} 