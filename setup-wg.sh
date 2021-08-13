#!/bin/bash

set -eo pipefail 

terraform init
terraform apply -auto-approve
ansible-playbook -i inventory wireguard-playbook.yml
echo "------------------"
echo "Please get your client's wireguard-configs in: ./wireguard-gateway/etc/wireguard/...."
echo "------------------"
echo ""
echo "To destroy wireguard node run: terraform destroy "
