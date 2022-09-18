# Zabbix server 6.2 Installation on Vmware ESXI
>
>VMware ESXi is an enterprise-class, type-1 hypervisor developed by VMware for deploying and serving virtual computers. So we're gonna install our virtual machines here. 
>- First of all we need to click 'virtual machines' button to see options to create our virtual machine. 

![[01-create-virtual-machine.png]](./vmware-image-source/01-create-virtual-machine.png)

>Than, create virtual machine by clicking 'create virtual machine' button in the ESXI administrator panel.

![[02-create-virtual-machine.png]](./vmware-image-source/02-create-virtual-machine.png)
> Before continue to create virtual machine, we need to download our ubuntu server 22.04 image file to our local machine. Than, add this image to our datastore via clicking the 'upload' button.

![[add-iso-image-to-datastore.png]](./vmware-image-source/add-iso-image-to-datastore.png)
> In the create vm menu, select 'Create a new virtual machine' and click 'next' button. 

![[03-create-virtual-machine.png]](./vmware-image-source/03-create-virtual-machine.png)
>Select your virtual machine name. Here, We're gonna install Ubuntu Server 22.04 so select Linux guest os family by distribution type Ubuntu Linux.

![[04-create-virtual-machine.png]](./vmware-image-source/04-create-virtual-machine.png)
>Select datastore that we have choosed for our Ubuntu Server image. Click next button when you choosed right datastore. After that we need to configure our virtual machine for Zabbix Server virtual machine. Check https://www.zabbix.com/documentation/current/en/manual/installation/requirements for system requirements that equal to your needs.

![[06-create-virtual-machine.png]](./vmware-image-source/06-create-virtual-machine.png)

> Select virtual machine image for booting and installing from there. Here, We're gonna choose Ubuntu Server 22.04 image file.

![[07-create-virtual-machine.png]](./vmware-image-source/07-create-virtual-machine.png)

![[08-create-virtual-machine.png]](./vmware-image-source/08-create-virtual-machine.png)

>Finally finish virtual machine configuration by clicking 'finish' button.

![[09-create-virtual-machine.png]](./vmware-image-source/09-create-virtual-machine.png)

>Now, we've virtual machine that ready to installation. So lets boot up this machine by clicking 'Power on' button.

![[10-create-virtual-machine.png]](./vmware-image-source/10-create-virtual-machine.png)

![[11-create-virtual-machine.png]](./vmware-image-source/11-create-virtual-machine.png)

## Installing Ubuntu Server 22.04
> After starting the virtual machine, we have another window for our Ubuntu Linux Server. Anyway we can connect this machine via ssh later.  Of course after finishing installation we're gonna connect to our machine via ssh(secure shell connection) to continue our zabbix installation.
>  - In the first configuration we're gonna setting up Our Ubuntu Server language. By default it's english. If you want to change by the way, push 'tab' button to switch and push 'enter' button to accept it.

![[01-ubuntu-server-installation.png]](./vmware-image-source/01-ubuntu-server-installation.png)

> In this configuration option we're gonna setting up keyboard layout. For changing layout push 'tab' button to pass another configuration option, to get in an option push 'space' button and use arrow keys to scroll up and down. When you have finish configuration push 'tab' button until you have reach out 'Done' button. Push 'enter' button to accept and finish configuration.

![[02-ubuntu-server-installation.png]](./vmware-image-source/02-ubuntu-server-installation.png)

> After that we have two option. First option we have base installation that already have some packages for various programs. Second option is minimal installation that let you install all packages after installation. For choosing an option push 'space' button and to switch another option push 'tab' button. After you complete the configuration push 'tab' button until you've reach the 'Done' button. Finish configuration by push 'enter' button.

![[03-ubuntu-server-installation.png]](./vmware-image-source/03-ubuntu-server-installation.png)

>Network configuration will automatically configure. But if you want to change network adapter and set static ip address, you can change now or you can change after installation.

![[04-ubuntu-server-installation.png]](./vmware-image-source/04-ubuntu-server-installation.png)

> If you want to configure a proxy for your Linux Server, you can configure here. By the way you can skip it if you dont need it. Then write Ubuntu archive mirror url here. By default it will automatically detect by your region. If you want you're free to change.

![[05-ubuntu-server-installation.png]](./vmware-image-source/05-ubuntu-server-installation.png)

>In this configuration screen we're gonna select our disk and create partition for Ubuntu Server virtual machine. You can select 'Use an entire disk' option to create partitions automatically. For customize partitioning select 'Custom storage layout' option.

![[06-ubuntu-server-installation.png]](./vmware-image-source/06-ubuntu-server-installation.png)

>We can see there our partition summary.

![[07-ubuntu-server-installation.png]](./vmware-image-source/07-ubuntu-server-installation.png)

> Here we're sure for that entire disk used for installation. Be sure that you've choosen right disk. You will not able to return this again. Otherwise just continue.

![[08-ubuntu-server-installation.png]](./vmware-image-source/08-ubuntu-server-installation.png)

> Choose your ubuntu server name and enter credentials for your root password.

![[09-ubuntu-server-installation.png]](./vmware-image-source/09-ubuntu-server-installation.png)

>We're gonna install OpenSSH server to our machine to connect via SSH(secure shell).

![[10-ubuntu-server-installation.png]](./vmware-image-source/10-ubuntu-server-installation.png)

>In this screen you can install some packages for different services. Skip that for default installation.

![[11-ubuntu-server-installation.png]](./vmware-image-source/11-ubuntu-server-installation.png)

> After that installation proccess will start. Remove the installation media and restart your vm.

## Zabbix Server Installation
> Zabbix is an open-source software tool to monitor IT infrastructure such as networks, servers, virtual machines, and cloud services. Zabbix collects and displays basic metrics from our on-prem servers, cloud applications. clusters etc. We've created architecture sample that we use in this tutorial.

![[system-design.jpg]](./vmware-image-source/zabbix-setup/system-design.jpg)

>Required services for zabbix server:
> - Postgresql database
> - Nginx web server
> - php8.1 (for backend)
> Before zabbix debian package installation, We need to prepare our Ubuntu Server to run Zabbix Web Interface.
> So we're gonna install nginx web server and php8.1 for backend purposes. First, update our repo. Run 'sudo apt update -y && sudo apt upgrade -y' command in terminal.

![[004-apt-upgrade-update.png]](./vmware-image-source/zabbix-setup/004-apt-upgrade-update.png)

> After completing update install nginx web server. Run 'sudo apt install nginx -y' command in terminal. Check if nginx web server running or not by running 'sudo systemctl status nginx.service' command. İf not run 'sudo systemctl enable nginx.service' command. Here is the tip.
> In linux, we can start, stop, enable on boot or restart any service. I'm gonna write them so you can use it during installation. For start, stop or restart service,
> - sudo systemctl "type here start, stop or restart" "service name".service
> For enabling service;
>  - sudo systemctl enable "service name".service

![[011-restart-nginx.png]](./vmware-image-source/zabbix-setup/011-restart-nginx.png)

> Install php for backend purposes by running 'sudo apt install php8.1-fpm php-pgsql' command. Enable php service by running 'sudo systemctl enable php8.1-fpm' command.

![[006-php-installation.png]](./vmware-image-source/zabbix-setup/006-php-installation.png)

> Install postgresql database system to our Ubuntu Server.
> Run 'sudo apt install postgresql postgresql-contrib -y' command.

![[007-postgresql-installation.png]](./vmware-image-source/zabbix-setup/007-postgresql-installation.png)

> Now, we're ready to install our Zabbix Server. First, we need to add zabbix repo to our ubuntu package repository.  Before that, change working directory to temporary directory for our debian package. Run 'cd /tmp' command. Run 'wget https://repo.zabbix.com/zabbix/6.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.2-1+ubuntu22.04_all.deb && sudo dpkg -i zabbix-release_6.2-1+ubuntu22.04_all.deb' command to download package and add zabbix package to the ubuntu repository. After adding the repo we need to update the system to take affect. Install zabbix server and its dependencies by running 'sudo apt update -y && sudo apt install zabbix-server-pgsql zabbix-frontend-php zabbix-sql-scripts zabbix-nginx-conf -y' command.

![[003-add-zabbix-repo-and-update.png]](./vmware-image-source/zabbix-setup/003-add-zabbix-repo-and-update.png)

> Enable and start postgresql database service. Run 'sudo systemctl enable postgresql.service' command. To start database service run 'sudo systemctl start postgresql.service' command. After that we need to create our database user for our Zabbix Server. To do that run 'sudo -u postgres createuser --pwprompt zabbix'
> command. In this command you can change username at last argument. Here, choose a password that you created previously. Also you're gonna use that password for authenticating your database so keep in mind that.

![[007-create-database-user.png]](./vmware-image-source/zabbix-setup/007-create-database-user.png)

> Create database for Zabbix Server. To do that run 'sudo -u postgres createdb -O zabbix -E Unicode -T template0 zabbix' command. Feel free to change your database name at last argument. After database creation we need to import schema for Zabbix Server. Run 'zcat /usr/share/doc/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix' command.

![[007-zcat-export-schema.png]](./vmware-image-source/zabbix-setup/007-zcat-export-schema.png)

> For self monitoring, we need to install zabbix agent here too. Zabbix agent needs to install on hosts for exporting logs and metrics. To do that run 'sudo apt install zabbix-agent -y' command.

![[005-install-zabbix-agent.png]](./vmware-image-source/zabbix-setup/005-install-zabbix-agent.png)

> We've finished installation, now we need to configure zabbix server and nginx server. First we're gonna edit 'zabbix_server.conf' file. Run 'sudo nano /etc/zabbix/zabbix_server.conf' command. Activate uncommented lines that contains 'DBPassword, DBUser, DBName' and change this lines with your credentials. In this tutorial we have database named 'zabbix', username 'zabbix' and password 'password1'. So we added this credentials. After finishing configuration file Press 'Control + X' then press 'Y' and enter.

![[009-zabbix-server.conf.png]](./vmware-image-source/zabbix-setup/009-zabbix-server.conf.png)

> For Zabbix Server web ui, edit nginx.conf file that located in '/etc/zabbix' directory. Run 'sudo nano /etc/zabbix/nginx.conf' command. Feel free to change listen port. We changed this port to '10459'. But keep in mind that port for allowing this port in firewall. Lastly  you can get rid of not necessary files by running 'sudo apt autoremove -y' command.

![[010-zabbix-nginx-conf.png]](./vmware-image-source/zabbix-setup/010-zabbix-nginx-conf.png)

> We have edited our config files. Now, lets enable and start zabbix server. Run 'sudo systemctl enable zabbix-server.service' command. To start zabbix server service run 'sudo systemctl start zabbix-server.service'  command. Also we can see status of our zabbix server by running 'sudo systemctl status zabbix-server.service' command.

![[013-zabbix-enable-systemctl.png]](./vmware-image-source/zabbix-setup/013-zabbix-enable-systemctl.png)

![[012-restart-zabbix-server.png]](./vmware-image-source/zabbix-setup/012-restart-zabbix-server.png)

> Now, our zabbix server accessable via web browser. Open your web browser and type 'http://'zabbix-server-ip-adress':10459'. If everything runs okay you need to see something like this.

![[001.png]](./vmware-image-source/zabbix-setup/zabbix_ui/001.png)

>Click next to start configuration. Here, you can see pre-requisites that already have. Click next to see next step.

![[002.png]](./vmware-image-source/zabbix-setup/zabbix_ui/002.png)

>Here, we're gonna enter our credentials that we created previously. For database username: 'zabbix', database password: 'Password1' and for database name 'zabbix'. Also choose database type 'postgresql'.

![[003.png]](./vmware-image-source/zabbix-setup/zabbix_ui/003.png)

> Check your timezone here.

![[004.png]](./vmware-image-source/zabbix-setup/zabbix_ui/004.png)

> Check summary of installation here.

![[summary.png]](./vmware-image-source/zabbix-setup/zabbix_ui/summary.png)

> We have entered default password and username here. default username: Admin, default password: zabbix.

![[005.png]](./vmware-image-source/zabbix-setup/zabbix_ui/005.png)

![[006.png]](./vmware-image-source/zabbix-setup/zabbix_ui/006.png)


>Now, we have finish zabbix installation and our server collecting data itself. I hope I explained it in the right way. Thanks for reading.
