output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_private_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.private[*].id
}

output "subnet_public_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.public[*].id
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web.id
}
output "cloudfront_url" {
  value = aws_cloudfront_distribution.cdn.domain_name
  description = "URL do CloudFront"
}