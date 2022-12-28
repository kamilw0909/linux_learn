1. Dodanie nowego użytkownika z konta root
  - `adduser kamil`
2. Dodanie nowego użytkownika do grupy sudo
  - `usermod -aG sudo kamil`
3. instalacja aktualizacji
  - `sudo apt dist-upgrade -y`
4. zmiana **hostname**
  - `sudo vim /etc/hostname`
    - jak mam domenę
    ```
    nextcloud.kamilw.cloud
    ```
  - `sudo vim /etc/hosts`
    - jeśli mam domenę, bo jak nie to piszę nextcloud
    ```
    127.0.1.1 nextcloud.kamilw.cloud
    ```
  - `reboot`
5. pobieranie servera nextcloud
  a. nextcloud.com --> Get Nextcloud --> Nextcloud server --> Community Projects/ Archive --> Archive --> kopiuje link Get Zip file
  b. wget https://download.nextcloud.com/server/releases/latest.zip

6. instalacja bazy danych pod serwer
  - `sudo apt install mariadb-server`
  - `sudo systemctl status mariadb` --> czy działa
  - `sudo mysql_secure_installation` --> zabezpiecznie db
    - enter current root pass --> ENTER --> chyba że w linuxie ustawiliśmy hasło dla roota
    - unix_socket authentication --> **no**
    - change root pass --> **yes**
    - remove anonimus users --> **yes**
    - disallow root login remotely --> **yes**
    - remove test db --> **yes**
    - reload priviliges tables --> **yes**
7. konfiguracja mariadb
  - `sudo mariadb`
  - `CREATE DATABASE nextcloud;`
  - `SHOW DATABASES;`
  - `GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'moje_hasło';`
  - `FLUSH PRIVILEGES'`
  - CTRL+D --> wyjście

8. Apache / php
  - `sudo apt install php php-apcu php-bcmath php-cli php-common php-curl php-gd php-gmp php-imagick php-intl php-mbstring php-mysql php-zip php-xml` --> zainstaluje apache2 z dependency
  - `sudo systemctl status apache2`
  - `sudo a2enmod dir env headers mime rewrite ssl`
    - `sudo systemctl restart apache2`
  - `sudo phpenmod bcmath gmp imagick intl`

9. Instalacja nextcloud
  - `which unzip`
  - `sudo apt install unzip`
  - `unzip latest.zip`
  - `rm latest.zip`
  - `mv nextcloud nextcloud.mojadomena.cloud`
  - `sudo chown www-data:www-data -R nextcloud.mojadomena.cloud`
  - `sudo mv nextcloud.mojadomena.cloud /var/www/`

10. apache Virtual Host
  - `sudo a2dissite 000-deafult.conf`
  - `sudo vim /etc/apache2/sites-available/nextcloud.mojadomena.cloud.conf`:
```
<VirtualHost *:80>
    DocumentRoot "/var/www/nextcloud.mojadomena.cloud"
    ServerName nextcloud.mojadomena.cloud

    <Directory "/var/www/nextcloud.mojadomena.cloud/">
        Options MultiViews FollowSymlinks
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>

    TransferLog /var/log/apache2/nextcloud.mojadomena.cloud._access.log
    ErrorLog /var/log/apache2/nextcloud.mojadomena.cloud_error.log

</VirtualHost>
```
  - `sudo a2ensite nextcloud.mojadomena.cloud.conf`
 
11. PHP
  - `sudo vim /etc/php/8.1/apache2/php.ini`
```
memory_limit = 512M
upload_max_filesize = 200M
max_execution_time = 360
post_max_size = 200M
date.timezone = Europe/Warsaw
opcache.enable=1
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=10000
opcache.memory_consumption=128
opcache.save_comments=1
opcache.revalidate_freq=2
```

  - **`sudo systemctl restart apache2`**

12. Nextcloud na serwerze działa - wystarczy wejść na adres ip serwera
  - tworzenie konta admina
  - db --> tak jak stworzyłem

13. Naprawianie bugów
  - secure connection/ ssl:
    - `sudo apt install snapd`
    - `sudo snap install core; sudo snap refresh core`
    - `sudo snap install --classic certbot`
    - `sudo ln -s /snap/bin/certbot /usr/bin/certbot`
        - `sudo certbot --apache` --> ssl certyfikat
  - http header:
    - `sudo vim /etc/apache2/sites-available/nexcloud.mojadomena.cloud-le-ssl.conf` --> dodaj pod ServerName
```
<IfModule mod_headers.c>
    Header always set Strict-Transport-Security "max-age=15552000; includeSubDomains"
</IfModule>
```
  - phone region:
    - `sudo vim /var/www/nextcloud.mojadomena.cloud/config/config.php`:
        - dodać pod 'installed' => true,
            - `'default_phone_region' => 'PL',`
    - `sudo chmod 660 /var/www/nextcloud.mojadomena.cloud/config/config.php`
  - no memory cache --> w tym samym pliku co powyżej dodać linijkę:
    - `'memcache.local' => '\\OC\\Memcache\\APCu',`
  - imagick:
    - `sudo apt install libmagickcore-6.q16-6-extra`
    - `sudo systemctl restart apache2`

  - cron:
    - `sudo apt install cron`
    - `sudo crontab -u www-data -e`:
        - `*/5 * * * * /usr/bin/php8.1 -f /var/www/nextcloud.mojadomena.cloud/cron.php` --> zapisz
