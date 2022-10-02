# polecenia
`pidof nazwa_procesu` --> podaje pid procesu
`ps -ef | grep [x]eyes` --> przez nawiasy grep nie wyszukuje grepa
`pgrep -a -u user_name bash` --> lista bashy

# ile pamięci zajmuje proces?
- proces uruchamia się i prosi o pamięć określoną
- używa też bibliotek współdzielonych
- inne procesy też mogą korzystać z tej samej biblioteki współdzielonej
- żeby ocenić ile pamięci potrzebujemy innego mechanizmu
	- `ps aux` --> pakuje procesy wszystkich userówfre
		- wyświetla w momencie uruchomienia
	- `pmap -d nr_pid` --> pokazuje pamięć wykorzystaną wraz z bibliotekami
	- `top` --> wyświetla info o procesie na bieżąco
	- `mpstat` --> info chwilowe o cpu

# uruchamianie procesów
- ^C --> zatrzymanie procesu z pierwszego planu
- `program &` --> uruchomienie w tle
- `jobs` --> pokazuje co jest w tle uruchomione
- `fg` --> przywrócenie programu na pierwszy plan
	- jak jest dużo procesów to przywracamy `fg nr_procesu`
	- + --> pierwszy w kolejce	 - drugi w kolejce
- jak proces już uruchomiony w pierwszym planie:
	- ^Z --> stopuje proces	
	- `bg`

- ^C --> wysłanie komunikatu do procesu że chcemy kill
	- jak proces nie wie jak go obsłużyć to zabija się
	- ale może być zaimplementowana obługa procesu
- `watch -n 1 proces`

## sygnały
- `kill pid` --> sygnał C^, sygnał o nr 2, INT
- `kill -9  pid` --> zawsze zabija proces
	- nie da się go przechwycić
- kill `pidof nazwa_procesu` LUB $(nazwa_procesu) --> przekazanie do polecenia parametrów w apostrowach odwróconych
- `killall nazwa`
	- w solarisie oznacza zabicie wszystkich procesów użytkownika

## multiplexery
- screen i tmux
- screen:
	- jak uruchomię  polecenie to po zamknięcia terminala polecenie nadal działa
	- wygodne do pracy z serwerem jak chcemy coś sprawdzić i wyłączyć a to nadal jest uruchomione

