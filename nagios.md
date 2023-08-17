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
3. contacts
4. host template
5. service template
6. commands --> poprzez dodanie pluginów
7. time periods
8. utwórz nowe foldery --> /usr/local/nagios i dodać to w nagios.cfg
9. service groups
10. instalacja i konfiguracja pnp4nagios
11. instalacja i konfiguracja NagVis i NDOUtils żeby zrobić dashboard
