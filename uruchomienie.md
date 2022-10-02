# Złamanie hasła roota:

muszę siedzieć fizycznie do komputera

e --> edit
	edytowanie pliku konfiguracyjnego gruba
		init=/bin/bash
		ro => rw LUB w BASH --> mount -o rw.remount /
^X --> bootuje
- loguje się do roota i mogę zmienić hasło
!! można założyć hasło na roota
nie da się prostymi poleceniami zrestartować systemu
	- trzeba wyłączyć komputerami
	- ale mogą nie zapisać się zmiany
	- trzeba przeonotować /
	- mount -o ro,remount /

# init
`runlevel` --> pokazuje poziom pracy
