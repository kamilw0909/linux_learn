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


a. WINDOWS --> trzeba mieć POWER SHELL
```
Get-Service -Name *ssh*
Start-Service sshd

Set-Service -Name sshd -StartupType 'Automatic'

Start-Service ‘ssh-agent’

Set-Service -Name ‘ssh-agent’ -StartupType 'Automatic'

New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22


- restart sshd i agenta: `services.msc` --> restart opensshagent, openssh server

- nie działa ssh-agent -->
```
Get-Service ssh-agent
Get-Service ssh-agent | Select StartType
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
```

- nie działa ssh-agent -->
```
Get-Service ssh-agent
Get-Service ssh-agent | Select StartType
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
```

b. upgrade PowerShell do ver >= 3.0
```

```



