cmdlety są zbudowane czasownik-rzeczownik flagi
  np set-alias
wyszukiwanie:
  - -verb co_chce_wyszukać --> slowo* --> zaczyna się od slowo
  - -noun cos -verb robi

get-command --> służy do wyszukiwania polecenia

get-help -name polecenie --> służy do wyświetlenia opisu

żeby pomoc była bardziej szczegółowa trzeba doinstalować ją:
update-help
  -force --> wymusza pobieranie help bo można tylko raz dziennie

$pshome --> pokazuje miejsce instalacji powershella

obiekt | get-member --> zwraca info o wyjściu obiektu

## formatowanie wyjścia
- pokazuje o wiele więcej info, bo standardowe wyjście korzysta z widoku obiektu Out-Default
polecenie | Format-List -property *
- get-member pokazuje co moge wyświeltlić na wyjściu, które kolumny
  | get-member -name C*
Get-Process zsh | Select-Object -Property Id, Name, CPU

## sortowanie wyjścia
Get-Process | Sort-Object -Descending -Property Name
Get-Process 'some process' | Sort-Object -Property @{Expression = "Name"; Descending = $True}, @{Expression = "CPU"; Descending = $False}  --> dla name odwrócone kolejnosc, dla cpu nieodwrócona

Get-Process | Where-Object CPU -gt 2 | Sort-Object CPU -Descending | Select-Object -First 3