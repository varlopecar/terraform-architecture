terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}



# Réseau commun
resource "docker_network" "app_net" {
  name = "app_net"
}

# MongoDB (local ou Atlas)
resource "docker_image" "mongo" {
  count = var.mongo_atlas_uri == "" ? 1 : 0
  name  = var.mongo_image
}

resource "docker_container" "mongo" {
  count = var.mongo_atlas_uri == "" ? 1 : 0
  name  = "mongo"
  image = docker_image.mongo[0].name
  networks_advanced {
    name = docker_network.app_net.name
  }
  env = [
    "MONGO_INITDB_ROOT_USERNAME=${var.mongo_user}",
    "MONGO_INITDB_ROOT_PASSWORD=${var.mongo_password}",
    "MONGO_INITDB_DATABASE=${var.mongo_database}"
  ]
  ports {
    internal = 27017
    external = 27017
  }
  command = ["--bind_ip_all"]
  volumes {
    host_path      = "${abspath(path.module)}/mongo-init"
    container_path = "/docker-entrypoint-initdb.d"
  }
}

# MySQL
resource "docker_image" "mysql" {
  name = var.mysql_image
}
resource "docker_container" "mysql" {
  name  = "mysql"
  image = docker_image.mysql.name
  networks_advanced {
    name = docker_network.app_net.name
  }
  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${var.mysql_password}"
  ]
  ports {
    internal = 3306
    external = 3306
  }
  volumes {
    host_path      = "${abspath(path.module)}/sqlfiles"
    container_path = "/docker-entrypoint-initdb.d"
  }
}

# Adminer
resource "docker_image" "adminer" {
  name = var.adminer_image
}
resource "docker_container" "adminer" {
  name  = "adminer"
  image = docker_image.adminer.name
  networks_advanced {
    name = docker_network.app_net.name
  }
  ports {
    internal = 8080
    external = 8081
  }
}

# Ajout de mongo-express (seulement si MongoDB local)
resource "docker_image" "mongo_express" {
  count = var.mongo_atlas_uri == "" ? 1 : 0
  name  = "mongo-express:latest"
}

resource "docker_container" "mongo_express" {
  count = var.mongo_atlas_uri == "" ? 1 : 0
  name  = "mongo_express"
  image = docker_image.mongo_express[0].name
  networks_advanced {
    name = docker_network.app_net.name
  }
  env = [
    "ME_CONFIG_MONGODB_SERVER=mongo",
    "ME_CONFIG_MONGODB_PORT=27017",
    "ME_CONFIG_MONGODB_ADMINUSERNAME=${var.mongo_user}",
    "ME_CONFIG_MONGODB_ADMINPASSWORD=${var.mongo_password}"
  ]
  ports {
    internal = 8081
    external = 8082
  }
  depends_on = [docker_container.mongo[0]]
}

# Node.js API (MongoDB)
resource "docker_image" "node_api" {
  name = var.node_image
}

resource "docker_container" "node_api" {
  name  = "node_api"
  image = docker_image.node_api.name
  networks_advanced {
    name = docker_network.app_net.name
  }
  env = [
    var.mongo_atlas_uri != "" ? "MONGODB_URI=${var.mongo_atlas_uri}" : "MONGODB_URI=mongodb://${var.mongo_user}:${var.mongo_password}@mongo:27017/${var.mongo_database}?authSource=admin",
    "PORT=3001",
    "NODE_ENV=production"
  ]
  ports {
    internal = 3001
    external = 3001
  }
  depends_on = [docker_container.mongo[0]]
}

# Python API (MySQL)
resource "docker_image" "python_api" {
  name = var.python_image
}
resource "docker_container" "python_api" {
  name  = "python_api"
  image = docker_image.python_api.name
  networks_advanced {
    name = docker_network.app_net.name
  }
  env = [
    "MYSQL_HOST=mysql",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${var.mysql_password}",
    "PORT=8000"
  ]
  ports {
    internal = 8000
    external = 8000
  }
  depends_on = [docker_container.mysql]
}

# React App
resource "docker_image" "react_app" {
  name = var.react_image
}
resource "docker_container" "react_app" {
  name  = "react_app"
  image = docker_image.react_app.name
  networks_advanced {
    name = docker_network.app_net.name
  }
  env = [
    "VITE_API_URL=http://localhost:8000",
    "VITE_NODE_API_URL=http://localhost:3001"
  ]
  ports {
    internal = 3000
    external = 3000
  }
} 