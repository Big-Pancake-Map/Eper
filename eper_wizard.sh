#! /usr/bin/bash

echo "***************************"
echo "* Welcome to 🍓 Wizard 🪄  *"
echo "***************************"

apt install sudo -y
echo -e "\n1️⃣  - Get updates and upgrades."
sudo apt-get update & sudo apt-get upgrade -y

echo -e "\n3️⃣  - Install a few prerequisite packages which let apt use packages over HTTPS."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

echo -e "\n4️⃣  - Then add the GPG key for the official Docker repository to your system."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo -e "\n5️⃣  - Add the Docker repository to APT sources."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo -e "\n6️⃣  - Update your existing list of packages again for the addition to be recognized."
sudo apt update -y

echo -e "\n7️⃣  - Make sure you are about to install from the Docker repo instead of the default Ubuntu repo."
apt-cache policy docker-ce

echo -e "\n8️⃣  - Intall Docker."
sudo apt install docker-ce -y

echo -e "\n9️⃣  - Install Docker Compose."
sudo apt-get install docker-compose-plugin -y

echo -e "\n🔟 - Check Docker Compose version."
docker compose version

echo -e "\n1️⃣ 1️⃣  - Install NGINX."
sudo apt install nginx -y

echo -e "\n1️⃣ 2️⃣  - start NGINX."
sudo systemctl start nginx.service

echo -e "\n1️⃣ 3️⃣  - Prepare port 80."
sudo iptables -I INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -I OUTPUT -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED -j ACCEPT

echo -e "\n1️⃣ 4️⃣  - Remove the default configration file."
#FILE=/etc/nginx/sites-enabled/default
#if [ -f "$FILE" ]; then
#	sudo unlink "$FILE"
#fi

echo -e "\n1️⃣ 5️⃣  - Create new nginx reverse proxy configuration file."
#read -p "What is your app name: " app_name
#echo "Creating $app_name.conf file..."

#cat <<EOF >app_name.conf
#server {
#    listen 80;
#    listen [::]:80;    
#
#    server_name 130.61.35.12 www.130.61.35.12;    
#
#    location / {
#        proxy_pass http://127.0.0.1:8080;
#        proxy_http_version 1.1;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection 'upgrade';
#        proxy_set_header Host $host;
#        proxy_cache_bypass $http_upgrade;
#    }
#
#    location /pgadmin4 {
#       proxy_pass http://127.0.0.1:8888;
#       proxy_set_header X-Script-Name /pgadmin4;
#    }
#}
#EOF
