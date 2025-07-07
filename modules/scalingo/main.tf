# Main Application (React Frontend + Python Backend)
resource "scalingo_app" "main_app" {
  name = var.app_name
  region = var.region
}

# Blog API Application (Node.js + MongoDB)
resource "scalingo_app" "blog_api" {
  name = var.blog_api_name
  region = var.region
}

# MySQL Addon for main app
resource "scalingo_addon" "mysql" {
  app = scalingo_app.main_app.id
  provider_id = "mysql"
  plan = "mysql-starter-512"
}

# MongoDB Addon for blog API
resource "scalingo_addon" "mongodb" {
  app = scalingo_app.blog_api.id
  provider_id = "mongodb"
  plan = "mongodb-starter-512"
}

# Container types for main app
resource "scalingo_container_type" "web" {
  app = scalingo_app.main_app.id
  name = "web"
  amount = 1
  size = "S"
}

resource "scalingo_container_type" "api" {
  app = scalingo_app.main_app.id
  name = "api"
  amount = 1
  size = "S"
}

# Container types for blog API
resource "scalingo_container_type" "blog_web" {
  app = scalingo_app.blog_api.id
  name = "web"
  amount = 1
  size = "S"
}

# Environment variables for main app
resource "scalingo_app" "main_app_env" {
  app = scalingo_app.main_app.id
  
  env = {
    NODE_ENV = "production"
    VITE_API_URL = "https://${scalingo_app.main_app.url}"
    VITE_BLOG_API_URL = "https://${scalingo_app.blog_api.url}"
  }
}

# Environment variables for blog API
resource "scalingo_app" "blog_api_env" {
  app = scalingo_app.blog_api.id
  
  env = {
    NODE_ENV = "production"
    PORT = "3001"
  }
}

# GitHub integration for main app
resource "scalingo_app" "main_app_github" {
  app = scalingo_app.main_app.id
  
  github_repo = "varlopecar/${var.project_name}"
  github_branch = "main"
  auto_deploy = true
}

# GitHub integration for blog API
resource "scalingo_app" "blog_api_github" {
  app = scalingo_app.blog_api.id
  
  github_repo = "varlopecar/${var.project_name}-blog-api"
  github_branch = "main"
  auto_deploy = true
}

# Domain configuration for main app
resource "scalingo_domain" "main_app_domain" {
  app = scalingo_app.main_app.id
  name = "${var.app_name}.osc-fr1.scalingo.io"
}

# Domain configuration for blog API
resource "scalingo_domain" "blog_api_domain" {
  app = scalingo_app.blog_api.id
  name = "${var.blog_api_name}.osc-fr1.scalingo.io"
}

# SSL certificate for main app
resource "scalingo_ssl_certificate" "main_app_ssl" {
  app = scalingo_app.main_app.id
  certificate = file("${path.module}/certs/main_app.crt")
  private_key = file("${path.module}/certs/main_app.key")
}

# SSL certificate for blog API
resource "scalingo_ssl_certificate" "blog_api_ssl" {
  app = scalingo_app.blog_api.id
  certificate = file("${path.module}/certs/blog_api.crt")
  private_key = file("${path.module}/certs/blog_api.key")
} 