```bash

#!/bin/bash

# Master Node

# Update package manager repositories
sudo apt-get update

#Install Docker
sudo apt install docker.io -y
sudo chmod 666 /var/run/docker.sock

# Install necessary dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
sudo mkdir -p -m 755 /etc/apt/keyrings

# Add Kubernetes Repository and GPG Key
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.33/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.33/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Update Package List
sudo apt update

# Install Kubernetes Components
sudo apt install -y kubeadm=1.28.1-1.1 kubelet=1.28.1-1.1 kubectl=1.28.1-1.1

# Initialize Kubernetes Master Node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Configure Kubernetes Cluster
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy Networking Solution (Calico)
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Deploy Ingress Controller (NGINX)
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml
```

# Worker Node
