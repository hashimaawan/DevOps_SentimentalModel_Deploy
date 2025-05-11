variable "name" {
  description = "Prefix name for all resources"
  type        = string
}

variable "cpu" {
  description = "CPU units for the Fargate task"
  type        = number
}

variable "memory" {
  description = "Memory (MB) for the Fargate task"
  type        = number
}

variable "desired_count" {
  description = "Number of task replicas"
  type        = number
}

variable "image_tag" {
  description = "ECR image tag to deploy"
  type        = string
}

variable "environment" {
  type = map(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs for ECS service"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for the ECS service"
  type        = string
}
