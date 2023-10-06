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


module.security-group_db.aws_security_group.this_name_prefix[0] has changed
  ~ resource "aws_security_group" "this_name_prefix" {
        id                     = "sg-005271bbe7801b061"
      ~ ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "MySQL/Aurora"
              + from_port        = 3306
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 3306
            },
          + {
              + cidr_blocks      = []
              + description      = ""
              + from_port        = 3306
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = [
                  + "sg-05066e5c84bf893f6",
                ]
              + self             = false
              + to_port          = 3306
            },
        ]
        name                   = "RDS Security Group-20231004075254131500000002"
        tags                   = {
            "Name" = "RDS Security Group"
        }
        # (8 unchanged attributes hidden)