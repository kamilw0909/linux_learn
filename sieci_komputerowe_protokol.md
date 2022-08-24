1. Warstwa aplikacji
	- aplikacje sieciowe i ich protokoły
	- protokoły:
		- SMTP - przesyłanie wiadomości pocztowych
		- HTTP - żądania pobrania stron www
		- FTP  - pozwala na transfer plików między dwoma hostami
		- DNS - translacja adresu 32 bit (ip) na adres przyjazny userowi
	- pakiet nazywa się ***komunikat*** 
2. Warstwa transportowa
	- przesyła komunikaty wartwy aplikacji między klientem a serwerem tworzącym aplikację
	- protokoły:
		- TCP - usługa zorientowana na połączenie, gwarantuje dostarczenie kompunikatów i zapewnia kontrolę przepływu (zgodność szybkości transmisji nadawcy i odbiorcy); dzieli długie komunikaty na segmenty; zapewnia mechanizm kontroli przeciążenia sieci
		- UDP - świadczy usługę aplikacjom bezpołączeniową, bardzo uproszczona, nie zapewnia niezawodności i kontroli przepływu i przeciążenia
	- pakiet nazywa się ***segment*** 
3. Warstwa sieci
	- przesyła pakiety od jednego hosta do drugiego
	- TCP lub UDP przekazuje segment i adres docelowy warstwie sieci, warstwa sieci oferuje segmentwowi dostarczenie go warstwie transportowej docelowego hosta
	- protokoły:
		- IP - definuje pola datagramu i to jak mają być przetwarzane przez routery i hosty
		- zawiera też protokoły routingu, które są w IP
	- pakiet nazywa sie ***datagram***
4. Warstwa łącza danych
	- zadaniem jest przemieszczenie całych ramek od jednego elementu sieci do kolejnego z nim sąsiadującego
	- warstwa sieci korzysta z routerów i hostów do przesłania datagramu do hosta docelowego, aby przemieścić pakiet z jednego węzła do kolejnego na trasie wartwa sieci korzysta z wartswy łącza danych
	- warstwa łącza danych na koniec przesyła pakiet do warstwy łącza sieci
	- to jakie usługi są zapewniane przez warstwę łącza danych zależy od protokołu który obłsuguje łącze
	- protokoły:
		- Ethernet
		- Wi-Fi
		- PPP
	- pakiety nazywane są ***ramka***
5. Warstwa fizyczna
	- rolą jest przesłanie poszczególnych bitów ramki pomiędzy dwoma węzłami
	- protokoły są zależne od łącza i rzeczywistej szybkości oferowanej przez nośnik łącza


MODEL OSI
