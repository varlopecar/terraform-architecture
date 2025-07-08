output "app_id" {
  description = "ID of the main application"
  value       = "placeholder-app-id"
}

output "app_url" {
  description = "URL of the main application"
  value       = local.app_url
}

output "blog_api_id" {
  description = "ID of the blog API application"
  value       = "placeholder-blog-api-id"
}

output "blog_api_url" {
  description = "URL of the blog API application"
  value       = local.blog_api_url
}

output "mysql_addon_id" {
  description = "ID of the MySQL addon"
  value       = "placeholder-mysql-addon-id"
}

output "mongodb_addon_id" {
  description = "ID of the MongoDB addon"
  value       = "placeholder-mongodb-addon-id"
}

output "main_app_domain" {
  description = "Domain of the main application"
  value       = "your-app.scalingo.io"
}

output "blog_api_domain" {
  description = "Domain of the blog API"
  value       = "your-blog-api.scalingo.io"
} 