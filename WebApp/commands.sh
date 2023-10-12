terraform init -backend-config="key=dev/terraform.tfstate" -reconfigure
terraform plan -out=dev.plan -var-file=dev.tfvars
terraform apply dev.plan


# terraform init -backend-config="key=stage/terraform.tfstate" -reconfigure
# terraform plan -out=stage.plan -var-file=stage.tfvars
# terraform apply stage.plan


# terraform init -backend-config="key=prod/terraform.tfstate" -reconfigure
# terraform plan -out=prod.plan -var-file=prod.tfvars
# terraform apply prod.plan
