# instalacja
`sudo pacman -S openssh` --> instaluje client i server

# klient

## opcje `ssh`
- -v więcej info podczas połączenia
- -p port
- -i plik do wczytania

## folder /home/user/.ssh
- zawiera znane hosty z którymi się łączyłem
- zawiera publiczne klucze do sparowania ze zdalnym serwerem
- kofiguracja globalna jest w ***/etc/ssh/ssh-config***

## konfiguracja klienta ~/.ssh/config
- wpisz w pliku:
  - Host nazwa_polaczenie
  -     Hostname nazwa
  -     Port 22
  -     User username
- plik nie może mieź uprawnień zapisu dla żadnej grupy lub other ze względów bezpieczeństwa:
  - `chmod go-w config`
- leczenie przez `ssh nazwa_polaczenia`

## TWORZENIE KLUCZA SSH
- należy wyłączyć łączenie przy pomocy hasła żeby było bezpieczniej
- tworzę w ~/.ssh
- `ssh-keygen` - tworzenie klucza (sprawdź czy to nienadpisuje wcześniejszego klucza)
  - typy kluczy:
    - `ssh-keygen -t ed25519 -C 'komentarz na końcu klucza'deafult nazwa i host mój`
  - trzeba podać tylko nazwę nowego klucza bez ścieżki
  - dobrze podac passphraze bo jest bezpieczniej
- połaczenie przy pomocy klucza, aby nie prosił serwer o hasło:
  - `ssh -i ~/.ssh/private_key login@host`
- połączenie żeby nie trzeba używać za każdym razem passphraze ***ssh-agent***
  - `ps aux | grep ssh-agent` --> sprzwdzenie czy działa
  - `eval "$(ssh-agent)" --> uruchomienie ssh-agent
  - `ssh-add ~/.ssh/prywanty_klucz_dodany_do_agenta`
  - można łączyć się przez `ssh login@host`

### Dodawanie klucza na serwer
1. opcja hard kopiuje klucz *.pub z klienta, loguje się na serwer i wklejam do folderu .ssh w pliku ***authorized_keys***
2. opcja easy `ssh-copy-id -i sciezka_do_pliku login@host`
  - w Windows być może trzeba zrobić folder `C:\Users\user-name\.ssh`
  - dobra opcja (tylko trzeba byc w folderze ~/.ssh:
```
sftp user@192.168.0.100
mkdir .ssh
cd .ssh
put id_rsa.pub
bye
```
  - dodatkowo trzeba zmienić config sshd i wykomentować w C:\ProgramData\ssh\sshd_config i restart openssh w services.msc:
```
AuthorizedKeysFile  .ssh/authorized_keys 
PasswordAuthentication no
PubkeyAuthentication yes
#Match Group administrators
#       AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys
```


# Serwer
- konfiguracja jest w ***/etc/ssh/sshd_config***
  - w folderze są też fingerprinty i jak zostaną usunięte nie da się połączyć z serwerem
- najważniejsze opcje:
  - Port 22
  - PermitRootLogin yes --> można logować się na root na serwerze
  - PasswordAuthentication yes --> należy wyłączyć jak jest ustawiony ssh key
  - 
- po zmianie konfiguracji trzeba zrestartować deamona:
  - `systemctl restart sshd`
  - `systemctl status sshd` --> trzeba sprawdzić czy nie ma błędów bo nie da się połączyć ponownie z serwerem

# problemy
- sprawdz uprawnienia plików .ssh
- sprawdzenie loga --> `journalctl -fu ssh` lub sshd/ bez -f to pokazuje całego loga z -f śledzi loga
