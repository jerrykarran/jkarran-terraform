# --------output.tf --------#

output "vpc" {
  value = module.vpc.vpc_id
}

output "security_group_public" {
  value = module.security_group_public.security_group_id
}

output "security_group_db" {
  value = module.security_group_db.security_group_id
}

output "ec2_instance_public1" {
  value = module.ec2_instance_public1.id
}

output "ec2_instance_public2" {
  value = module.ec2_instance_public2.id
}

# output "db_arn" {
#   value = module.db.db_instance_arn
# }