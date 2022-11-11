# 1. Czynności wstępne
`apt update`
`apt dist-upgrade`
`vi /etc/hostname`
  - zmiana nazwy hosta np nazwa domeny to pokarze wszystko przed kropką
`vi /etc/host`
  - `127.0.1.1 nazwa.hosta`
`reboot`
  - żeby zmiany zatweirdzić

# 2. Apache
`apt install apache2 apache2-doc apache2-utils`
`systemctl status apache2`
  - spr czy jest aktywny deamon
  - `systemctl enable apache2` --> startuje po restarcie linux
  - `systemctl reload` --> przeładowuje apache
`ip_addr` --> w przeglądarce powinna być strona apache

## Konfiguracja apache
a. modules
  - `apt search libapache2-mod` --> pokazuje listę dostępnych modółów apache
    - `apt install libapache3-mod-python` --> python support

  - moduły w ubuntu są po instalacji automatycznie uruchomione
  - `a2enmod` --> pokazuje uruchomione moduły apache
    - wpisuje nazwę i pokazuje czy jest uruchomiony
  - `a2dismod` --> wyłączenie modułu
  - `systemctl restart apache2` --> trzeba po zmianach w modułach
b. virtual host
  - `a2ensite` / `a2dissite` --> włączenie/ wyłączenie vhosta
  - `ls /etc/apache2/sites-available` --> lista vhostów
  - `vi /etc/apache2/sites-available/example.net.conf`
'''
<VirtualHost *:80> 
    ServerAdmin webmaster@example.net
    ServerName example.net
    ServerAlias www.example.net
    DocumentRoot /srv/www/example.net/public_html/
    ErrorLog /srv/www/example.net/logs/error.log
    CustomLog /srv/www/example.net/logs/access.log combined
</VirtualHost>
'''
  - vhost pod skrypt perla
'''
<VirtualHost *:80> 
    ServerAdmin webmaster@example.org
    ServerName example.org
    ServerAlias www.example.net
    DocumentRoot /srv/www/example.org/public_html/
    ErrorLog /srv/www/example.org/logs/error.log
    CustomLog /srv/www/example.org/logs/access.log combined
    OptionsExecCGI
    AddHandler cgi-script .pl
</VirtualHost>
'''
  - `a2ensite example.net` --> i drugiego też żeby działał (pod perla)
  - `systemctl reload apache2` --> po zmianie vhost

