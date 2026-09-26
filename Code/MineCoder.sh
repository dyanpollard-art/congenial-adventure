#!/bin/bash


set -e

echo "=== 1. Updating repositories and installing packages ==="
sudo apt update
sudo apt install -y guacamole tomcat9

echo "=== 2. Reloading system configurations ==="
sudo ldconfig
sudo systemctl daemon-reload

echo "=== 3. Enabling and starting services ==="
sudo systemctl enable --now guacd
sudo systemctl enable --now tomcat9

echo "=== 4. Cloning the repository ==="
git clone https://github.com/dyanpollard-art/congenial-adventure

echo "=== 5. Navigating to the project directory ==="
cd congenial-adventure
cd Code

echo "=== 6. Deploying the application via Docker Compose ==="
sudo docker compose -f coding.yml up -d

echo "=== Deployment Completed Successfully ==="
