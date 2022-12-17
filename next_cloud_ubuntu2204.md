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

8. Apache
  - `sudo apt install php php-apcu php-bcmath php-cli php-common php-curl php-gd php-gmp php-imagick php-intl php-mbstring php-mysql php-zip php-xml` --> zainstaluje apache2 z dependency
  - 
