variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket to host the static site"
}

variable "api_dns_name" {
  description = "DNS name of the backend ALB"
  type        = string
}

variable "name" {
  description = "Prefix used for naming CloudFront origins and behaviors"
  type        = string
}