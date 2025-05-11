output "cluster_id" {
  description = "The ECS cluster ARN"
  value       = aws_ecs_cluster.this.id
}

output "service_name" {
  description = "The ECS service name"
  value       = aws_ecs_service.app.name
}

output "api_url" {
  description = "DNS name of the ALB in front of the backend API"
  value       = aws_lb.api.dns_name
}