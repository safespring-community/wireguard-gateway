#!/bin/bash

set -eo pipefail 
if [ -e terraform ]; then
    terraform init
    terraform apply -auto-approve
else if [ -e tofu ]; then
    tofu init
    tofu apply -auto-approve
else
    echo "Can't find neither Terraform nor OpenTofu"
    exit 1


ansible-playbook -i inventory wireguard-playbook.yml
echo "------------------"
echo "Please get your client's wireguard-configs in: ./wireguard-gateway/etc/wireguard/...."
echo "------------------"
echo ""
echo "To destroy wireguard node run: terraform destroy "
