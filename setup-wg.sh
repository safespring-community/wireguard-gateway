#!/bin/bash

set -eo pipefail 

terraform init
terraform apply -auto-approve
ansible-playbook -i inventory wireguard-playbook.yml
echo "------------------"
echo "Please get your client's wireguard-config in: ./wireguard-gateway/etc/wireguard/user_1/wg0.conf" 
echo "------------------"
echo ""
echo "To destroy wireguard node run: terraform destroy "
