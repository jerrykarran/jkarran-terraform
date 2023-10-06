    key    = "jkarran/state-file"
terraform init -backend-config="state_configuration/s3-state-bucket.hcl" \
-backend-config="state_configuration/dev-s3-state-key.hcl" \
-migrate-state
terraform plan
terraform apply