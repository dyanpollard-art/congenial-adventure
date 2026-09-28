#!/bin/bash


set -e

echo "=== 1. Updating repositories and installing packages ==="
yay -S guacamole-server
export CFLAGS="$CFLAGS -Wno-error"
sudo systemctl enable --now guacd
yay -S guacamole-client-bin
sudo ln -s /usr/share/guacamole/guacamole.war /var/lib/tomcat10/webapps/guacamole.war
sudo systemctl enable --now tomcat10
sudo mkdir -p /etc/guacamole
sudo nano /etc/guacamole/guacamole.properties
guacd-hostname: localhost
guacd-port: 4822
sudo systemctl restart guacd tomcat10

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
