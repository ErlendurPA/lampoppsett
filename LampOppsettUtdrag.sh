#!/bin/bash

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install necessary packages
sudo apt install -y apache2 mariadb-server php php-mysql

# Configure the firewall
sudo ufw allow ssh
sudo ufw enable
sudo ufw allow http
sudo ufw allow https

# Navigate to the web directory and clone the GitHub repository
cd /var/www/html
sudo git clone https://github.com/Example/Exampleproject.git
sudo chmod -R 755 Exampleproject

# Restart Apache and MariaDB services
sudo systemctl restart apache2
sudo systemctl restart mariadb

# Setup MariaDB user
sudo mysql -e "CREATE USER 'example'@'localhost' IDENTIFIED BY 'example';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Modify apache2.conf to set DocumentRoot to Exampleproject
sudo sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/Exampleproject|' /etc/apache2/sites-available/000-default.conf
sudo sed -i 's|<Directory /var/www/>|<Directory /var/www/html/Exampleproject/>|' /etc/apache2/apache2.conf

# Restart Apache to apply changes
sudo systemctl restart apache2

# Open the Apache configuration file for editing (optional step)
sudo nano /etc/apache2/apache2.conf
