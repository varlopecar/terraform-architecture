# Docker Network
resource "docker_network" "app_network" {
  name = var.network_name
  driver = "bridge"
}

# MySQL Database
resource "docker_image" "mysql" {
  name = "mysql:8.0"
}

resource "docker_container" "mysql" {
  name  = var.mysql_container_name
  image = docker_image.mysql.image_id
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  env = [
    "MYSQL_ROOT_PASSWORD=rootpassword",
    "MYSQL_DATABASE=react_form_db",
    "MYSQL_USER=app_user",
    "MYSQL_PASSWORD=app_password"
  ]
  
  ports {
    internal = 3306
    external = var.mysql_port
  }
  
  volumes {
    container_path = "/var/lib/mysql"
    host_path      = "${path.module}/data/mysql"
  }
  
  restart = "unless-stopped"
}

# MongoDB Database
resource "docker_image" "mongodb" {
  name = "mongo:6.0"
}

resource "docker_container" "mongodb" {
  name  = var.mongodb_container_name
  image = docker_image.mongodb.image_id
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  env = [
    "MONGO_INITDB_ROOT_USERNAME=admin",
    "MONGO_INITDB_ROOT_PASSWORD=adminpassword",
    "MONGO_INITDB_DATABASE=blog_db"
  ]
  
  ports {
    internal = 27017
    external = var.mongodb_port
  }
  
  volumes {
    container_path = "/data/db"
    host_path      = "${path.module}/data/mongodb"
  }
  
  restart = "unless-stopped"
}

# Python FastAPI Backend
resource "docker_image" "backend" {
  name = "react-form-backend:latest"
  build {
    context = "../../react-form/backend"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "backend" {
  name  = var.backend_container_name
  image = docker_image.backend.image_id
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  env = [
    "DATABASE_URL=mysql+pymysql://app_user:app_password@${var.mysql_container_name}:3306/react_form_db",
    "SECRET_KEY=your-secret-key-here",
    "ALGORITHM=HS256",
    "ACCESS_TOKEN_EXPIRE_MINUTES=30"
  ]
  
  ports {
    internal = 8000
    external = var.backend_port
  }
  
  depends_on = [docker_container.mysql]
  restart = "unless-stopped"
}

# Node.js Blog API
resource "docker_image" "blog_api" {
  name = "blog-api:latest"
  build {
    context = "../../express-mongodb-app"
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "blog_api" {
  name  = var.blog_api_container_name
  image = docker_image.blog_api.image_id
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  env = [
    "MONGODB_URI=mongodb://admin:adminpassword@${var.mongodb_container_name}:27017/blog_db?authSource=admin",
    "PORT=3001",
    "NODE_ENV=production"
  ]
  
  ports {
    internal = 3001
    external = var.blog_api_port
  }
  
  depends_on = [docker_container.mongodb]
  restart = "unless-stopped"
}

# React Frontend
resource "docker_image" "frontend" {
  name = "react-form-frontend:latest"
  build {
    context = "../../react-form"
    dockerfile = "Dockerfile.frontend"
    args = {
      VITE_API_URL = "http://localhost:${var.backend_port}"
      VITE_BLOG_API_URL = "http://localhost:${var.blog_api_port}"
    }
  }
}

resource "docker_container" "frontend" {
  name  = var.frontend_container_name
  image = docker_image.frontend.image_id
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  ports {
    internal = 80
    external = var.frontend_port
  }
  
  depends_on = [docker_container.backend, docker_container.blog_api]
  restart = "unless-stopped"
}

# Adminer (Database Management)
resource "docker_image" "adminer" {
  name = "adminer:latest"
}

resource "docker_container" "adminer" {
  name  = var.adminer_container_name
  image = docker_image.adminer.image_id
  
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  env = [
    "ADMINER_DEFAULT_SERVER=${var.mysql_container_name}"
  ]
  
  ports {
    internal = 8080
    external = var.adminer_port
  }
  
  depends_on = [docker_container.mysql]
  restart = "unless-stopped"
} 