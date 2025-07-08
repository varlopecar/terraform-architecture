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
  description = "Image Docker de l'API Node.js (Express + MongoDB)"
  type        = string
  default     = "docker.io/varlopecar/express-mongodb-app:latest"
}

variable "python_image" {
  description = "Image Docker de l'API Python (FastAPI)"
  type        = string
  default     = "docker.io/varlopecar/ci_cd_fastapi_ynov:latest"
}

variable "react_image" {
  description = "Image Docker de l'app React"
  type        = string
  default     = "docker.io/varlopecar/ci_cd_react_ynov:latest"
}

# Additional variables for GitHub integration
variable "github_repository" {
  description = "GitHub repository name"
  type        = string
  default     = "ci-cd"
}

variable "github_owner" {
  description = "GitHub repository owner"
  type        = string
  default     = "varlopecar"
}

