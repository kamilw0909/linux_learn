# 1. Czynności wstępne
- `apt update`
- `apt dist-upgrade`
- `vi /etc/hostname`
  - zmiana nazwy hosta np nazwa domeny to pokarze wszystko przed kropką
- `vi /etc/host`
  - `127.0.1.1 nazwa.hosta`
- `reboot`
  - żeby zmiany zatweirdzić

# 2. Apache
- konfiguracja jest w /etc/apache2/apache2.conf
- pliki stron www są w /var/www/
- `apt install apache2 apache2-bin apache2-data  apache2-doc apache2-utils`
- `systemctl status apache2`
  - spr czy jest aktywny deamon
  - `systemctl enable apache2` --> startuje po restarcie linux
  - `systemctl reload` --> przeładowuje apache
- `ip_addr` --> w przeglądarce powinna być strona apache

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
    ```
        <VirtualHost *:80> 
            ServerAdmin webmaster@example.net
            ServerName example.net
            ServerAlias www.example.net
            DocumentRoot /srv/www/example.net/public_html/
            ErrorLog /srv/www/example.net/logs/error.log
            CustomLog /srv/www/example.net/logs/access.log combined
        </VirtualHost>
    ```
  - vhost pod skrypt perla
    ```
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
    ```
  - `a2ensite example.net` --> i drugiego też żeby działał (pod perla)
  - `systemctl reload apache2` --> po zmianie vhost

### <Directory path>
- pozwala skonfigurować dostęp do konkretnego foleru apacheowi
- opcje:
    - Options FollowSymLinks --> pozwala stronie www używać symlinków do plików z path
    - AllowOverride none --> nie pozwala .htaccess nadpisywać ustawień
    - Order allow, deny --> ustawie jakie hosty, ip adresy mogą mieć dostęp do strony
    Indexes --> jako plik ma być wczytany jako index.html


# Konfiguracja ubuntu - apache - django
1. projekt django z venv ma być w `/var/www/html` lub `var/www/`
2. virtual host w `/etc/apache2/sites-available`:
```
<VirtualHost *:80>
    ServerAdmin admin@ipse.app
    ServerName ipse.app
    ServerAlias www.ipse.app
    DocumentRoot /var/www/html/django_ipse
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
 
    Alias /static /var/www/html/django_ipse/static
    <Directory /var/www/html/django_ipse/static>
        Require all granted
    </Directory>
 
    Alias /static /var/www/html/media
    <Directory /var/www/html/django_ipse/media>
        Require all granted
    </Directory>
    <Directory /var/www/html/django_ipse/conf>
        <Files wsgi.py>
            Require all granted
        </Files>
    </Directory>

    WSGIDaemonProcess django_ipse python-path=/var/www/html/django_ipse python-home    =/var/www/html/django_ipse/env
    WSGIProcessGroup django_ipse
    WSGIScriptAlias / /var/www/html/django_ipse/config/wsgi.py
</VirtualHost>
```
1. `sudo a2ensite nazwa_vhosta`
2. `sudo a2dissite 000-default` --> wyłączenie deafaulta z localhostu
3. `sudo vi /etc/hosts`
    - `127.0.0.1   ipse.app` --> aby możnabyło korzystać z adresu www zamiast ip
4. django projekt --> config/settings.py
    - `ALLOWED_HOSTS = ['ipse.app']
5. `sudo systemctl reload apache2`


## Uprawnienia/wlasność do plików z których korzysta apache
- `chown -R www-data:www-data /sciezka/do/plikow/`
