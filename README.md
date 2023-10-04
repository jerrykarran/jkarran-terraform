# jk terraform

terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
terraform apply -refresh-only

terraform show | grep “public_ip”

terraform plan -out plan_name
terraform plan plan_name

terraform -lock-timeout=60s

terraform init -reconfigure
terraform init -migrate-state
terraform state show aws_vpc.main
terraform init -backend-config=state_configuration/dev_local.hcl -migratestate


value = module.NAME_OF_MODULE.OUTPUT_NAME