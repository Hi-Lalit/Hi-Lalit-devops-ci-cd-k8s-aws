import json

# Paths
TFSTATE_FILE = "/home/gautam/devops-ci-cd-k8s-platform/terraform.tfstate"
INVENTORY_FILE = "/home/gautam/devops-ci-cd-k8s-platform/ansible/inventory.yml"

# Load terraform state
with open(TFSTATE_FILE, "r") as f:
    tfstate = json.load(f)

# Get Jenkins public IP
new_ip = tfstate["outputs"]["jenkins_public_ip"]["value"]

# Update only ansible_host in inventory
with open(INVENTORY_FILE, "r") as f:
    lines = f.readlines()

with open(INVENTORY_FILE, "w") as f:
    for line in lines:
        if line.strip().startswith("ansible_host:"):
            f.write(f"          ansible_host: {new_ip}\n")
        else:
            f.write(line)

print(f"✔ ansible_host updated to {new_ip}")
