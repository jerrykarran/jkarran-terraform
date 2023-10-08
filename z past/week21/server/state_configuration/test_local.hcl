path = "state_data/terraform.test.tfstate"
terraform init -backend-config=state_configuration/dev_local.hcl -migrate-state
terraform plan
terraform apply