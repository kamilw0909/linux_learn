# klient

## opcje `ssh`
- -v więcej info podczas połączenia

## folder /home/user/.ssh
- zawiera znane hosty z którymi się łączyłem
- zawiera publiczne klucze do sparowania ze zdalnym serwerem

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

