# Wstęp
- sprawdz czy jest zainstalowany openssh klient i serwer na serwerze
- zrobić połączenie SSH key pair
  - jeden klucz kopiuje do każdego serwera/hosta
- warto zrobić git repo na playbooki
- zainstaluj pakiet ansible

# Konfiguracja
- tworzenie pliku ***inventory*** w którym przechowywane są ip/hosty serwerów
- plik konfiguracyjny ansible ***ansible.cfg***
  - zawartość:
    - [defaults]
    - inventory = inventory
    - private_key_file = ~/.ssh/private_ansible_key
  - globalny jest w /etc/ansible
  - wtedy polecenie skraca się do `ansible all -m ping`

# używanie
- wykonanie jednego polecenia na wszystkich serwerach
  - `ansible all --key-file ~/.ssh/ansible_key_public -i plik_inventory -m ping`
- lista hostów:
  - `ansible all --list-hosts`
- info o hostach:
  - `ansible all -m gather-facts`
  - `ansible all -m --limit nazwa_hosta` --> info tylko o jednym hoście
- update debian distro
  - `ansible all -m apt -a update_cache=true --become --ask-become-pass`
- --become --ask-become-pass --> opcja żeby wykonywać jako sudo polecenia na serwerze
- instalacja jednej paczki na każdym serwerze:
  - `ansible all -m apt -a name=vim-nox --become --ask-become-pass`
- upgrade aplikacji:
  - `ansible all -m apt -a "name=snapd state=latest" --become --ask-become-pass`
- upgrade OS:
  - `ansible all -m apt -a "upgrade=dist" --become --ask-become-pass`

# Playbook
- tworzenie pliku yaml ze skryptem:
  - `ansible-playbook --ask-become-pass nazwa_playbooka.yml`
  - w yml:
    - state: latest --> zainstaluj najnowszą wersję
    - state: absent --> usuń pakiet

