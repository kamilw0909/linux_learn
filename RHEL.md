## statyczny adres IP:

`# vim /etc/sysconfig/network-scripts/ifcfg-enp0s3`
```
TYPE="Ethernet"
BOOTPROTO="none"
NAME="enp0s3"
IPADDR="192.168.20.150"
NETMASK="255.255.255.0"
GATEWAY="192.168.20.1"
DEVICE="enp0s3"
ONBOOT="yes"
```
`# systemctl restart NetworkManager`


## apache 2

### instalacja
`sudo dnf check-update`
`sudo dnf install httpd httpd-tools`
`sudo systemctl enable --now httpd`
`sudo systemctl status httpd`
`sudo systemctl status firewalld.service`
`sudo firewall-cmd --zone=public --add-service=http --permanent`
`sudo firewall-cmd --zone=public --add-service=https --permanent`
`sudo firewall-cmd --reload`
`sudo firewall-cmd --list-all`

### pliki html
`/var/www/html`

### dostęp przeglądarki do strony na serwerze rhel
`chcon -R -t httpd_sys_rw_content_t /var/www/html`


