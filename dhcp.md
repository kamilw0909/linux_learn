- serwer podpinam do głównego switcha

1. wybór oprogramowania:
 - ISC DHCP
2. instalacja:
  - `apt install isc-dhcp-server`
3. wskazanie karty do nasłuchiwania:
  a. edycja pliku /etc/init.d/isc-dhcp-server
    - `INTERFACESv4="nazwa karty sieciowej - enp0s8"
4. konfiguracja dhcp:
  - w pliku /etc/dhcp/dhcp.conf
  - zrób kopię pliku
  - ```
    authoritative; # nasz serwew jest jedyny w sieci
    subnet 10.0.0.0 netmask 255.255.255.0 { # adres ***sieci*** przypisany do naszego interfejsu
    range 10.10.0.101 10.0.0.200;
    option domain-name-server 8.8.8.8 8.8.4.4;
    option domain-name "ubuntu.dhcp_lub_costam";
    option routers 10.0.0.1; # ważne, przyda się przy konfiguracji NAT - wpisujemy ten do którego jestem podpięty z serwerem
    option broadcast-adress 10.10.0.255;
    default-lease-time 259200;
    max-lease-time 338400;
    }
    ```
5. restart isc
  - systemctl ...

## rezerwacja ip dla urządzeń typu drukarka
 `dhcp-lease-list` --> wyświetla listę klientów które mają adresy z naszej puli
 - edycja w pliku /etc/dhcp/dhcp.conf
 - ```
   host nazwa_hosta {
   hardware ethernet MAC_ADRESS; --> kopia z dhpc-lease-list
   fixed-adress 10.0.0.222;
   }
   ```
 - restart isc

## VLAN
 - /etc/netplan/costam_rozna_nazwa.yaml
 - ```
   ethernets:
   vlans:
    nazwa_karty_siecowej_serwera.10: # 10 do nr vlan enp2s0
      id: 10
      link: nazwa_fizycznej_karty_serwera_enp2s0
      addresses: [10.0.10.1/24] # adres wirtualnego interfejsu
   nazwa...20:
     ...
 - restart netplan:
   - `netplan apply`

 - w konfiguracji dhpc:
   - zmieniamy nazwy sieci subnet, range, option router tak aby zgadzały się z netplan --> 10.0.0.1 --> 10.0.10.1 # pole adresses
   - robimy subnet dla każdego vlan
   - restart isc

## log 
- /var/log/syslog

