#Ansible Windows 7/10

1. Instalacja:
    - `sudo apt update`
    - `sudo apt install ansible`
2. Przygotowanie pliku **inventory**
    - w nim bedą adresy ip hostów do zarządzania przez ansible
3. Tworzenie **repo git**
    - init, remote, commit, push
6. Testowanie połączenie z serwerami:
    - `ansible all -i inventory -m win_ping`
7. Tworzenie ansible configa
    - `vim ansible.cfg`
```
[defaults]
inventory = inventory
```

8. Polecenia
    - lista hostów w inventory --> `ansible all --list-hosts`
    - info o hostach --> `ansible -m gather_facts`
    - info o jednym hoscie --> `ansible -m gather_facts --limit 192.168.1.123

# konfiguracja windows:

- linux ma miec ansible i **pywinrm** --> pip install 

## UPGRADE POWER SHELL I .NET
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://raw.githubusercontent.com/jborean93/ansible-windows/master/scripts/Upgrade-PowerShell.ps1"
$file = "$env:temp\Upgrade-PowerShell.ps1"
$username = "Administrator"
$password = "Password"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force

&$file -Version 5.1 -Username $username -Password $password -Verbose
```

```
Set-ExecutionPolicy -ExecutionPolicy Restricted -Force
$reg_winlogon_path = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $reg_winlogon_path -Name AutoAdminLogon -Value 0
Remove-ItemProperty -Path $reg_winlogon_path -Name DefaultUserName -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $reg_winlogon_path -Name DefaultPassword -ErrorAction SilentlyContinue
```

## WinRM
### sprawdzenie konfiguracji
```
winrm enumerate winrm/config/Listener
winrm get winrm/config/Service
winrm get winrm/config/Winrs
```
### konfiguracja WinRM
```
winrm quickconfig
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
```
