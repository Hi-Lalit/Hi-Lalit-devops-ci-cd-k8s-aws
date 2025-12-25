#!/bin/bash
set -e

# This script initializes Terraform, validates the configuration,

cd terraform-aws-infra

terraform init
terraform validate
terraform apply -auto-approve

# terraform destroy -auto-approve

# ./run-terraform.sh