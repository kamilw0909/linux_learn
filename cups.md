#Instalowanie drukarki na serwerze z Debian 13:
```
apt update
apt install cups cups-filters hplip hplip-data ghostscript -y
vim /etc/cups/cupsd.conf
  Wprowadź następujące zmiany:
  Zmień Listen localhost:631 na Port 631.
  W sekcji <Location /> dopisz Allow 192.168.1.0/24.
  W sekcji <Location /admin> dopisz Allow 192.168.1.0/24.
systemctl restart cups

lpadmin -p "NAZWA_DRUKARKI" \
    -v "socket://IP_DRUKARKI:9100" \
    -m "hp:/path/to/model.ppd" \
    -E -L "Lokalizacja" -D "Opis drukarki"
```
Zadanie             |Komenda
Status drukarek     |lpstat -p -d
Czyszczenie kolejki |cancel -a -x
Usuwanie drukarki   |lpadmin -x NAZWA_DRUKARKI
Logi błędów	tail -f |/var/log/cups/error_log

# przywrócenie możliwości drukowania w kolorze dla drukarki:
`lpadmin -p nazwa_drukarki_cups -o ColorModel=RGB`

# sprawdzenie konfiguracji konkretnej drukarki
`lpoptions -p nazwa_drukarki_cups -l`
