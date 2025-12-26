#!/bin/bash

set -e

# This script initializes Terraform, validates the configuration,

# getting the public IP of the Jenkins EC2 instance from Terraform output 
# and creating the Ansible inventory file dynamically.

cd /home/gautam/devops-ci-cd-k8s-platform/terraform-aws-infra

IP=$(terraform output -raw jenkins_public_ip)

echo "jenkins_public_ip=${IP}" > ec2_ip.env

cd /home/gautam/devops-ci-cd-k8s-platform/ansible

cat ./inventory.yml
cat <<EOF > /home/gautam/devops-ci-cd-k8s-platform/ansible/inventory.yml
all:
  children:
    webservers:
      hosts:
        jenkins:
          ansible_host: ${IP}
          ansible_user: ubuntu
          ansible_ssh_private_key_file: /home/gautam/.ssh/devops-key
EOF

# Then it runs the Ansible playbooks to configure Jenkins and Docker.

cd /home/gautam/devops-ci-cd-k8s-platform/ansible

ansible all -i inventory.yml -m ping

# ansible-playbook -i inventory.yml jenkins.yml
ansible-playbook -i inventory.yml docker.yml

# ./run-ansible.sh