output "app_id" {
  description = "ID of the main application"
  value       = scalingo_app.main_app.id
}

output "app_url" {
  description = "URL of the main application"
  value       = scalingo_app.main_app.url
}

output "blog_api_id" {
  description = "ID of the blog API application"
  value       = scalingo_app.blog_api.id
}

output "blog_api_url" {
  description = "URL of the blog API application"
  value       = scalingo_app.blog_api.url
}

output "mysql_addon_id" {
  description = "ID of the MySQL addon"
  value       = scalingo_addon.mysql.id
}

output "mongodb_addon_id" {
  description = "ID of the MongoDB addon"
  value       = scalingo_addon.mongodb.id
}

output "main_app_domain" {
  description = "Domain of the main application"
  value       = scalingo_domain.main_app_domain.name
}

output "blog_api_domain" {
  description = "Domain of the blog API"
  value       = scalingo_domain.blog_api_domain.name
} 