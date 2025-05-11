variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "backend_image_tag" {
  description = "The tag of the ECR image to deploy for the backend (e.g. git SHA or ‘latest’)."
  type        = string
}

variable "db_url" {
  description = "Database connection URL, typically provided via secrets manager or SSM."
  type        = string
}

variable "name" {
  description = "Prefix (e.g. myapp-dev) used for naming all resources"
  type        = string
}