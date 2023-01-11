1. Instalacja
- `python3 -m pip install --user ansible`

2. Stwórz **inventory** gdzie będą zapisane hosty
- folder inventory --> `/etc/ansible/hosts`
```
[mojewirtualnemaszyny]
192.0.2.50
user@192.0.2.51
192.0.2.52
```

3. Sprawdź hosty
- `ansible all --list-hosts`

4. Konfiguracja SSH, żeby ansible mogło komunikować się z hostami
- dodaj public_key to pliku authorized_keys w każdym hoście

5. wykonywanie polecenia na serwerze:
- `ansible all -m apt -a update_cache=true --become ask-become-pass`
