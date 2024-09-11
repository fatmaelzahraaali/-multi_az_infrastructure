#Automated Multi-AZ Infrastructure and Docker Setup with Terraform and Ansible

##This project automates the deployment of infrastructure across two availability zones (AZs) on AWS using Terraform and configures Docker on private EC2 instances using Ansible. The project follows GitOps principles, with infrastructure and configuration management integrated into a CI/CD pipeline.

#Table of Contents

-Project Overview
-Prerequisites
-Project Structure
-Usage
-CI/CD Pipeline
-Ansible Workspaces

#Project Overview

Terraform provisions a VPC, public and private subnets, EC2 instances in an Auto Scaling Group (ASG), a Load Balancer, and a Bastion Host.
Ansible installs Docker and deploys an NGINX container on private instances.
GitOps and CI/CD manage the deployment process using a Git repository and automation tools like GitHub Actions.

#Prerequisites
 Terraform
 Ansible
 AWS credentials with access to create VPCs, subnets, EC2 instances, and security groups.
 SSH key pair configured on AWS for access to EC2 instances.

#Project Structure

/terraform
  /modules
    /vpc
    /autoscaling
    /bastion
  - main.tf
  - outputs.tf

/ansible
  /workspaces
    /dev
    /prod
  - ansible.cfg
.github/workflows
  - terraform-ansible.yml

README.md

Terraform modules for creating VPC, Auto Scaling Group, and Bastion Host.
Ansible workspaces for managing environment-specific configurations (e.g., dev, prod).
GitHub Actions pipeline for automating the deployment process.

#Usage

##1-Clone the repository:

 git clone https://github.com/your-repo/your-project.git
 cd your-project

##2-Set up the infrastructure with Terraform:

In the /terraform directory, initialize and apply Terraform to provision the resources.

 cd terraform
 terraform init
 terraform apply -auto-approve

##3-Configure EC2 instances using Ansible:

 After Terraform deployment, switch to the ansible directory and apply the configuration based on the environment (dev or prod).

 cd ../ansible

 ansible-playbook -i workspaces/dev/inventory.ini workspaces/dev/playbook.yml
 
##4-Access the NGINX service via the Load Balancer:

The public IP of the Load Balancer can be found in the Terraform output. Visit the Load Balancer’s public IP in your browser to verify NGINX is running.

#CI/CD Pipeline
The CI/CD pipeline is configured using GitHub Actions. On every push to the main branch, the following tasks will be executed automatically:

###Terraform: Provisions or updates the infrastructure.
###Ansible: Configures EC2 instances and deploys Docker and NGINX containers.
You can find the CI/CD configuration in .github/workflows/terraform-ansible.yml.

#Ansible Workspaces
The Ansible playbooks are separated into different workspaces for different environments:

 workspaces/dev: For development environment.
 workspaces/prod: For production environment. 

Make sure to update the inventory files with the private IPs of your instances after deploying with Terraform.


