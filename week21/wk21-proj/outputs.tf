output "vpc_id" {
  description = "Output the ID for the primary VPC"
  value       = module.vpc.vpc_id
}

output "jk_autoscaling" {
  description = "Output the ID for the autoscaling group"
  value       = module.autoscaling.autoscaling_group_id
}

output "jk_security-group" {
  description = "Output the ID for the security group"
  value       = module.security-group.security_group_id
}

output "jk_alb" {
  description = "Output the ID for the alb"
  value       = module.alb.lb_id
}