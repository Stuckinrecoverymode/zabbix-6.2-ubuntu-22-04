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
>Select datastore that we have choosed for our Ubuntu Server image. Click next button when you choosed right datastore. After that we need to configure our virtual machine for Zabbix Server virtual machine. Check https://www.zabbix.com/documentation/current/en/manual/installation/requirements for system requirements for your needs.

![[06-create-virtual-machine.png]](./vmware-image-source/06-create-virtual-machine.png)
> Select virtual machine image for booting and installing from there. Here, We're gonna choose Ubuntu Server 22.04 image file.

![[07-create-virtual-machine.png]](./vmware-image-source/07-create-virtual-machine.png)
![[08-create-virtual-machine.png]](./vmware-image-source/08-create-virtual-machine.png)
