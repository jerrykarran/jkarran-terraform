output "vpc_id" {
  description = "Output the ID for the primary VPC"
  value       = aws_vpc.vpc.id
  #   sensitive   = true
}

output "phone_number" {
  value     = var.phone_number
  sensitive = true
}