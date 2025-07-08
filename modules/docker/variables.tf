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

# Variables pour MongoDB
variable "mongo_image" {
  description = "Image Docker MongoDB"
  type        = string
  default     = "mongo:6"
}

variable "mongo_user" {
  description = "Utilisateur root MongoDB"
  type        = string
  default     = "admin"
}

variable "mongo_password" {
  description = "Mot de passe root MongoDB"
  type        = string
  default     = "password"
}

variable "mongo_database" {
  description = "Nom de la base MongoDB"
  type        = string
  default     = "blog_db"
}

variable "mongo_atlas_uri" {
  description = "URI MongoDB Atlas (optionnel, remplace MongoDB local si défini)"
  type        = string
  default     = ""
  sensitive   = true
}

# Variables pour MySQL
variable "mysql_image" {
  description = "Image Docker MySQL"
  type        = string
  default     = "mysql:8"
}

variable "mysql_root_password" {
  description = "Mot de passe root MySQL"
  type        = string
  default     = "root"
}

variable "mysql_database" {
  description = "Nom de la base MySQL"
  type        = string
  default     = "user_registration"
}

variable "mysql_user" {
  description = "Utilisateur MySQL"
  type        = string
  default     = "user"
}

variable "mysql_password" {
  description = "Mot de passe utilisateur MySQL"
  type        = string
  default     = "password"
}

variable "adminer_image" {
  description = "Image Docker Adminer"
  type        = string
  default     = "adminer:latest"
}

variable "node_image" {
  description = "Image Docker de l'API Node.js"
  type        = string
}

variable "python_image" {
  description = "Image Docker de l'API Python"
  type        = string
}

variable "react_image" {
  description = "Image Docker de l'app React"
  type        = string
} 