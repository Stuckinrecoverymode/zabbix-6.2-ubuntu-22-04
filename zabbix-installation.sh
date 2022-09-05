#!/usr/bin/bash
# installing nginx
sudo apt update -y && sudo apt install nginx -y
sudo apt autoremove -y

# get zabbix debian package and adding to the repo
cd /tmp
wget https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1+ubuntu22.04_all.deb && sudo dpkg -i zabbix-release_6.2-1+ubuntu22.04_all.deb
sudo apt update -y && sudo apt upgrade -y && sudo apt install zabbix-server-pgsql zabbix-frontend-php zabbix-sql-scripts zabbix-nginx-conf -y
sudo apt install zabbix-agent -y
sudo apt autoremove -y

# installing php modules for backend purposes
sudo apt install php8.1-fpm php-pgsql

# postgresql database installation, user and database creation also export the schema that uses zabbix
sudo apt install postgresql postgresql-contrib -y
sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix -E Unicode -T template0 zabbix
zcat /usr/share/doc/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

# grafana installation
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# adding grafana debian repo
echo "deb https://packages.grafana.com/enterprise/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt update -y && sudo apt install grafana-enterprise -y

# enabling services
sudo systemctl enable zabbix-agent && sudo systemctl enable zabbix-server
sudo systemctl enable php8.1-fpm && sudo systemctl enable nginx
sudo systemctl enable grafana && sudo systemctl start grafana

# starting services
sudo systemctl start zabbix-agent && sudo systemctl start zabbix-server
sudo systemctl start php8.1-fpm && sudo systemctl start nginx
username=$(whoami)
cd /home/$username/
sudo cp zabbix_server.conf /etc/zabbix/
sudo cp zabbix_agent.conf /etc/zabbix/
sudo cp nginx_zabbix.conf /etc/zabbix/nginx.conf
# sudo nano /etc/zabbix/zabbix_server.conf
# sudo nano /etc/zabbix/zabbix_agent.conf
# sudo nano /etc/zabbix/nginx.conf
# sudo nano /etc/zabbix/php-fpm.conf
