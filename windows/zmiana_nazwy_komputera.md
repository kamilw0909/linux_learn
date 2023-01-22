## Sprawdzanie aktualnej nazwy
- cmd i powershell
`hostname`
`ipconfig /all`
## Windows 7 i 10
1. cmd
```
cmd --> jako admin
wmic computersystem where name="%computername%" call rename name="nowa-nazwa"
shutdown -r
```
2. powershell
`Rename-Computer -NewName "Nowa-nazwa"`
`shutdown -r`



