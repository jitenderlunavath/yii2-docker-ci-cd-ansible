Yii2 Application Deployment with Docker Swarm, Ansible, and GitHub Actions
This repository contains the setup for deploying a sample Yii2 PHP application using Docker Swarm on an AWS EC2 instance, with NGINX as a host-based reverse proxy, automated infrastructure setup via Ansible, and CI/CD via GitHub Actions.
Prerequisites

AWS EC2 instance (Ubuntu 22.04 recommended) with SSH access
GitHub repository with this code
GitHub Container Registry (GHCR) token (GHCR_TOKEN) stored in GitHub Secrets
EC2 SSH key (EC2_SSH_KEY) and host (EC2_HOST) stored in GitHub Secrets
Docker Hub or GHCR account for image storage

Setup Instructions

Clone the Repository
git clone https://github.com/your-username/your-repo.git
cd your-repo


Configure AWS EC2

Launch an EC2 instance (t2.medium or larger recommended).
Ensure port 80 is open in the security group.
Note the public IP and SSH key.


Ansible Setup

Update ansible/hosts with your EC2 instance IP:[ec2]
<EC2_PUBLIC_IP> anisble_ssh_user=ubuntu


Run the Ansible playbook:ansible-playbook -i ansible/hosts ansible/playbook.yml --user ubuntu --key-file <path-to-ec2-key.pem>




GitHub Actions Configuration

Add the following secrets in your GitHub repository:
GHCR_TOKEN: Token for GHCR access
EC2_HOST: EC2 public IP
EC2_SSH_KEY: EC2 SSH private key


Push changes to the main branch to trigger the CI/CD pipeline.


Access the Application

Open http://<EC2_PUBLIC_IP> in a browser to access the Yii2 application.



Assumptions

The Yii2 application is minimal and uses PHP 8.1.
Docker Swarm runs in single-node mode (multi-node can be extended).
NGINX runs on the host and proxies requests to the Docker Swarm service on port 8080.
The EC2 instance uses Ubuntu 22.04.
Rollback in CI/CD is not implemented but can be added using Docker service rollback commands.

Testing Deployment

Verify NGINX is running:
sudo systemctl status nginx


Check Docker Swarm services:
docker stack services yii2


Test the application:

Access http://<EC2_PUBLIC_IP> and verify the Yii2 welcome page.
Make a change to the app, push to main, and confirm the CI/CD pipeline updates the deployment.



Directory Structure
├── Dockerfile
├── docker-compose.yml
├── ansible/
│   └── playbook.yml
├── nginx/
│   └── yii2-app.conf
├── .github/
│   └── workflows/
│       └── deploy.yml
└── README.md

Troubleshooting

NGINX errors: Check logs at /var/log/nginx/yii2-error.log.
Docker issues: Verify Swarm status with docker info --format '{{.Swarm.LocalNodeState}}'.
CI/CD failures: Review GitHub Actions logs for SSH or image push errors.

