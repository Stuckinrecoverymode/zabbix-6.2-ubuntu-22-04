#!/usr/bin/zsh
# or just use bash instead
# run with sudo priviligies
# installing nginx

if [ $# -lt 4 ]; then
    echo "Usage: sudo ./zabbix-installation.sh <version> <DBName> <DBUser> <DBPassword> <port>"
    exit 1
fi

version=$1
DBName=$2
DBUser=$3
DBPassword=$4
Port=$5

 apt update -y &&  apt install nginx -y
 apt autoremove -y

# get zabbix debian package and adding to the repo
cd /tmp
wget https://repo.zabbix.com/zabbix/${version:0:3}/ubuntu/pool/main/z/zabbix-release/zabbix-release_$version+ubuntu22.04_all.deb &&  dpkg -i zabbix-release_$version+ubuntu22.04_all.deb
 apt update -y &&  apt upgrade -y &&  apt install zabbix-server-pgsql zabbix-frontend-php zabbix-sql-scripts zabbix-nginx-conf -y
 apt install zabbix-agent -y
 apt autoremove -y

# installing php modules for backend purposes
 apt install php8.1-fpm php-pgsql

# postgresql database installation, user and database creation also export the schema that uses zabbix
apt install postgresql postgresql-contrib -y
sudo -u postgres createuser --pwprompt "$DBUser"
sudo -u postgres createdb -O "$DBUser" -E Unicode -T template0 "$DBName"
zcat /usr/share/doc/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u "$DBUser" psql "$DBName"

# Prompt to install Grafana
read -p "Do you want to install Grafana? (y/n): " install_grafana

if [[ $install_grafana == "y" ]]; then
    apt-get install -y apt-transport-https
    apt-get install -y software-properties-common
    wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -

    # adding grafana debian repo
    echo "deb https://packages.grafana.com/enterprise/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list
    apt update -y && apt install grafana-enterprise -y

    # enabling and starting Grafana service
    systemctl enable grafana && systemctl start grafana
fi

# edit zabbix_server.conf
echo "DBName=$DBName" >> /etc/zabbix/zabbix_server.conf
echo "DBUser=$DBUser" >> /etc/zabbix/zabbix_server.conf
echo "DBPassword=$DBPassword" >> /etc/zabbix/zabbix_server.conf

# edit nginx.conf
sed -i "s/listen[[:space:]]*80;/listen $Port;/" /etc/zabbix/nginx.conf

# enabling services
systemctl enable zabbix-agent &&  systemctl enable zabbix-server
systemctl enable php8.1-fpm &&  systemctl enable nginx
# systemctl enable grafana &&  systemctl start grafana

# starting services
systemctl start zabbix-agent &&  systemctl start zabbix-server
systemctl start php8.1-fpm &&  systemctl start nginx
