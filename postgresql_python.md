# Instalacja
- `sudo python3-pip python3-dev libpq-dev postgresql postgresql-contrib'

# Tworzenie bazy danych i nowego usera

- `sudo -u postgres psql` --> logowanie do postgres
- postgres=# `CREATE DATABASE nazwaprojektu;` --> tworzenie bazy danych dla projektu, każdy projekt musi mieć swoją db
- postgres=# `CREATE USER nazwausera WITH PASSWORD 'password';` --> tworzenie usera żeby móc zarządzać db
- `ALTER ROLE nazwausera SET client_encoding TO 'utf8';`
- `ALTER ROLE nazwausera SET default_transaction_isolation TO 'read committed';`
- `ALTER ROLE nazwausera SET timezone TO 'Europe/Warsaw';
- --> konfiguracja db ^
- `GRANT ALL PRIVILEGES ON DATABASE nazwaprojektu TO nazwausera;` --> nadanie uprawnień userowi do db
- `\q` --> wyjście z postgresa

# Insalacja paczek postgresa do pracy z django
- `pip install psycopg2`
- settings.py: ```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'nazwadb',
        'USER': 'user_ktory_zarzadza_db',
        'PASSWORD': 'password',
        'HOST': 'localhost',
        'PORT': '',
    }
}
```

