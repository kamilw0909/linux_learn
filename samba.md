1. instalacja samby:
  - `apt install samba`
2. utworzenie użytkownika do logowania do udostępnionego katalogu
  - adduser user_name_samba
3. edytowanie konfiguracji samby:
  - conf --> /etc/samba/smb.conf
  - zrób kopie conf
  - ``` [dane]
          path = /sciezka_udostepnionego_katalogu
          browseable = yes
          read only = no
        [public]
          path = /sciezka_udostepnionego_katalogu
          browseable = yes
          read only = no
          guest ok = yes```
4. restart service
  - `systemctl restart smbd`
5. zmiana uprawnień udostępnionych katalogów na 777
  - `chown 777 /katalog`
6. połączenie u klienta:
  - Windows --> WIN + R --> \\adres_ip
  - LINUX --> w eksploratorze plików --> połącz z serwerem
