# rsync
`rsync opcje zrodlo cel`
- źródło/cel:
  - lokalny plik/katalog
  - zdalny plik/katalog --> `[user@]host:path`
  - zdalny serwer rsync określony za pomocą URI w postaci `rsync://[user@]host[:port]/path 
- nie jest wpierane kopiowanie zdalny do zdalnego
- opcje:
  - -a rekursja i zachowanie atrybutów plików
  - -v więcej info
