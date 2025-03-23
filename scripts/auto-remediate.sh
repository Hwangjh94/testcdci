#!/bin/bash
echo "Terraform auto remediation triggered"#!/bin/bash

# CloudWatch 이벤트가 Lambda를 트리거하면, 이 스크립트로 재적용
cd /var/task/project-root/terraform
tfenv use 1.3.0
terraform init
terraform apply -auto-approve -var-file="../environments/prod/terraform.tfvars"