## Architektura
- Serwer Nagios --> uruchamia plugin --> plugin na hoście zbiera dane --> wysyłanie odpowiedzi na serwer Nagios --> jak zmieni się STATE na HARD to NOTIFICATION do admina


## Terminy
- PLUGIN --> program/skrypt, który wykonuje się na zewnątrz
- HOST --> coś co monitoruje, to zazwyczaj komputer
- SERVICE --> coś co można zmierzyć - CPU, MEMORY USE, to zazwyczaj jakaś cześć komputera
- USERS --> kto ma dostęp do Nagiosa
- CONTACTS --> admin,
- CONTACT GROUP --> zby ułatwić notifications
- DOWNTIME --> kiedy, hosty są niedostępne, np z powodu zaplanowanej aktualizacji
- STATE --> soft/hard - zmienia się w zależności od dotępności hosta
- AGENT --> coś na hoście co sprawdza parametry monitorowane i komunikuje dane z Nagiosem
- ACKNOWLEDGMENT - wyłączenie powiadomień
- LATENCY --> różnica między zaplanowanym uruchomieniem a ty jak uruchomiony
- HOST GROUP --> żeby łatwiej tworzyć jednostki do monitowania w conf
- SERVICE GROUP --> podobnie jak z host group


## ACTIVE/ PASSIVE checks
- aktywne --> to te aktywowane przez serwer Nagios
- pasywne --> np aktywowana jest aplikacja na hości (CRON), ona przetrzymuje dane i Nagios pobiera to przez active check


## Instalacja
1. wyłącz selinux i firewall
2. pobierz Nagios Core
3. instalacja jak w manualu na stronie Nagiosa
4. zrób skrypt/polecenie do sprawdzenie konfiguracji Nagiosa:
  - `vim /bin/vnagios` -->
  ```
  #!/bin/bash
  /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
  ```
  - `chmod 777 /bin/vnagios`
5. Zainstaluje PLUGINY
  - tak jak na stronie Nagiosa

## Postinstalacja
- ! nie dodawaj hostów ani serwisów zaraz po instalacji
- najpierw konfiguracja
1. conf
2. template
  - default template jest w /usr/local/nagios/etc/objects/templates.cfg i go edytuje
  - mogę kilka zrobić dla np linux i windowsa osobno name linux-kamil name windows-kamil
  ```
  define host {
    name                            linux-kamil
    check_period                    24x7
    check_interval                  5
    retry_interval                  1
    max_check_attempts              10
    check_command                   check-host-alive
    notification_interval           120
    notification_options            d,u,r
    contacts_group                  nagiosadmins
    icon_image                      linux40.png     #/usr/local/nagios/share/images/logos/linux40.png
    statusmap_image                 linux40.png
    action_url                      /pnp4nagios/index.php/graph?host=$HOSTNAME$
    notifications_enabled            1
    event_handler_enabled           1
    flap_detection_enabled          1
    process_perf_data               1
    retain_status_information        1
    retain_nonstatus_information    1
    notification_period             24x7
    register                        0
  }

  define service {
    name                            service-kamil
    active_checks_enabled           1
    passive_checks_enabled          1
    parallelize_check              1
    obsess_over_service             1
    check_freshness                 0
    notifications_enabled          1
    flap_detection_enabled          1
    process_perf_data               1
    retain_status_information       1
    is_volatile                     0
    check_period                    24x7
    max_check_attempts              3
    check_interval                  10
    retry_interval                  2
    contact_groups                  nagiosadmins
    notification_options            w,c,r
    notification_interval           0
    notification_period             24x7
    action_url                      /pnp4nagios/index.php/graph?host=$HOSTNAME$
    flap_detection_enabled          1
    flap_detection_options          c
    register                        0
  }
  ```
  - sprawdź czy działa --> `sudo vnagios`
  - restart --> `sudo systemctl restart nagios`
3. contacts (conf w templates.cfg)
  - powiadomienia hosta rodzaje opcji:
    - d = down
    - u = unreachable
    - r = recovery
    - f = flapping (trzepoczący - pojawia sie i znika)
    - s = scheduled host down time
  - powiadomienia servic, rodzaje opcji:
    - w = warning
    - u = unknown
    - c = critical
    - r = recovery
    - f = flapping
    - s = scheduled service down time
  ```
  define contact {
    contact_name                    kamil
    use                             generic-contact
    alias                           Kamil W
    email                           kwar.sdrzdalne@gmail.com
  }

  ## contact groups
  define contactgroup {
    contactgroup_name               linuxadmins
    alias                           Linux Administrators
    members                         nagiosadmin,kamil
  }
  ```
  - `vnagios`, restart nagios.service
7. time periods (w pliku objects/timeperiods.cfg)
  - można swój dla jakiegoś czegoś do monitorowania:
  ```
  define timeperiod {
    name            godziny-pracy
    timeperiod_name godziny-pracy
    alias           Godziny pracy 8-16
    monday          8:00-16:00
    tuesday         8:00-16:00
    wednesday       8:00-16:00
    friday          8:00-16:00
  }
  ```

4. host i service define 
  - w folderze objects tworze nowy plik cfg np host1.cfg
  ```
  define host {
    use             linux-kamil
    host_name       t440p
    alias           Thinkpad T440p
    adress          192.168.1.183
    contacts        kamil
    contact_groups  linuxadmins
  }

  define service {
    use                     service-kamil
    hostname                t440p
    service_description     PING
    check_command           check_ping!100.00,20%!500.00,60%
    contacts                kamil
    contact_groups          linuxadmins
  }
  
  ```
  - edycja nagios.cfg
    -  dodaj plik cfg w pliku nagios.cfg

5. host groups define
  - tworze nowy plik w nagios/etc/hostgroups.cfg
  ```
  ddefine hostgroup {
    hostgroup_name  allservers
    alias           All Servers Monitored by Nagios
    members         localhost
  }

  define hostgroup {
    hostgroup_name  linux-servers
    alias           All Linux Monitored by Nagios
    members         localhost
  }

  define hostgroup {
    hostgroup_name  windows-servers
    alias           All Windows Monitored by Nagios
    members         localhost
  }
  ```
  - dodaj do nagios.cfg plik z tą konfoguracją

  - SERVICE GROUP --> tworze plik w nagios/etc/servicegroups.cfg

  ```
  define servicegroup {
    servicegroup_name           linux_memory
    alias                       Linux Used Memory
    members                     localhost, Swap Usage # z description servicu
  }
  ```
  - dodaj do nagios.cfg ten plik


6. commands --> poprzez dodanie pluginów

8. utwórz nowe foldery --> /usr/local/nagios i dodać to w nagios.cfg
9. service groups
10. instalacja i konfiguracja pnp4nagios
  - jaka na stronie supportu nagiosa:
    - https://support.nagios.com/kb/article/nagios-core-performance-graphs-using-pnp4nagios-801.html#RHEL
    - dostępne pod ip/pnp4nagios --> strona pokazuje czy są spełnione zależności
    - usuń plik `rm -rf /usr/local/pnp4nagios/share/install.php`
    - sprawdź zależności wchodze do folderu ze żródłami pnp4nagios i później do folderu scripts `./veryfipnp_config_v2.pl -m bulk -c /usr/local/nagios/etc/nagios.cfg -p /usr/local/pnp4nagios/etc/`
    - na stronie z instalacją na dole strony są informacja co trzeba jeszcze zrobić żeby wszystko działało
11. instalacja i konfiguracja NagVis i NDOUtils żeby zrobić dashboard
