output "site_url" {
  description = "The CloudFront distribution domain name for the React site"
  value       = aws_cloudfront_distribution.cdn.domain_name
}

output "cdn_id" {
  value = aws_cloudfront_distribution.cdn.id
}