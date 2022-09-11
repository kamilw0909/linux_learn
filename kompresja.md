# KOMPRESJA

## gzip
- format wyjściowy **.gz**
- kompresja jednego pliku lub wielu
- uruchomiony zastępuje oryginał plikiem skompresowanym
`gunzip` --> służ do dekompresji, nie trzeba podawać rozszerzenia .gz ale można
`gzip -d` --> działa jak gunzip

- można zrobić loga .gz --> `ls -l /etc | gzip > foo.txt.gz`
- tylko sprawdzenie zawartości --> `gunzip -c foo.txt | less`
  - podobnie działa **zcat** --> `zcat foo.txt.gz`

## bzip2
- wyjście **.bz2**
- działa podobnie jak bzip ale mocniej kompresuje kosztem czasu
- `bunzip2 plik` --> dekompresja
- ma też `bzcat` i `bzip2recover` do odzyskiwania uszkodzonego pliku

## zip
- `zip [opcje] plik.zip plik...`
- rozpakowywania --> `unzip plik.zip`
- nie można z niego korzystać do kopiowania plików przez np ssh w przeciwieństwie do tar
- opcje:
  -r pakuje rekursywnie podkatalogi
  -l wypisuje liste plikow w archiwum lub jeden plik
  -v więcej info
  -@ korzystanie z wejścia/wyjści

# ARCHIWIZACJA

## tar
- `tar [x opcje] plik_wyjsciowy plik_wejsciowy`
- wyjście **.tar** lub **.tgz** --> archiwum z użyciem gzip
- `tar tryb[opcje] ścieżka`
- tryby:
  f - można podać nazwę archiwum / wypisuje nazwy plików w archiwum --> używa plików/u
  v - bardziej szczegółowe info o archiwum
  c - tworzy archiwum na podstawie listy plików
  x - rozpakowuje
  r - dodaje pliki do archiwum na końcu
  t - listuje zawartość arciwum
  u - update archiwum jak są nowe pliki niż zawartość archiwum
  A - połączenie archiwów w jedno
  z - kompresja gzip
  j - kompresja bzip2
- używając myślnika zamiast nazwy pliku tar korzysta ze standordowego wyjścia/wejścia
- pliki rozpakowane będą należąć do usera który rozpakowuje archiwum a nie twórcy










