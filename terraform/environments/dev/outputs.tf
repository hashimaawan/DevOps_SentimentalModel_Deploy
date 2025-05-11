output "site_url" {
  description = "URL of the React frontend (CloudFront)"
  value       = module.frontend.site_url
}

output "cluster_id" {
  description = "ECS cluster ARN for the backend service"
  value       = module.backend.cluster_id
}

output "service_name" {
  description = "ECS service name for the backend"
  value       = module.backend.service_name
}

output "api_url" {
  description = "DNS name of the ALB in front of the backend API"
  value       = module.backend.api_url
}

output "distribution_id" {
  value       = module.frontend.cdn_id  # or aws_cloudfront_distribution.cdn.id if defined in root
  description = "The CloudFront distribution ID"
}

output "vpc_id" {
  description = "The VPC ID"
  value       = module.network.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs"
  value       = module.network.public_subnets
}