1. Instalacja:
    - `sudo apt update`
    - `sudo apt install ansible`
2. Przygotowanie pliku **inventory**
    - w nim bedą adresy ip hostów do zarządzania przez ansible
3. Tworzenie **repo git**
    - init, remote, commit, push
4. Tworzenie klucza ssh
5. Dodanie klucza **.pub** na serwery
6. Testowanie połączenie z serwerami:
    - `ansible all --key-file ~/.ssh/ansible -i inventory -m ping`
7. Tworzenie ansible configa
    - `vim ansible.cfg`
```
[defaults]
inventory = inventory
private_key_file = ~/.ssh/ansible
```

8. Polecenia
    a. lista hostów w inventory --> `ansible all --list-hosts`
    b. info o hostach --> `ansible -m gather_facts`
    c. info o jednym hoscie --> `ansible -m gather_facts --limit 192.168.1.123
