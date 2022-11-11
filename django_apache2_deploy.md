# UBUNTU REQUIREMENTS
sudo apt update

sudo apt install python3-pip apache2 libapache2-mod-wsgi-py3

# DEFAULT DJANGO PROJECT

### Tree projektu
'''
 django_project
 └── env (All ENV File)
 ├── manage.py
 └── my_django_project
     ├── init.py
     ├── settings.py
     ├── urls.py
     └── wsgi.py
'''

django projekt z venv

--> django projekt settings.py
    STATIC_ROOT = BASE_DIR / "static/"

--> django migracje
--> django create superuser
--> python manage.py collectstatic

systemctl restart apache2
--> runserver żeby sprawdzić czy działa na localhost

# APACHE CONFIGURATION
1. Stworzenie nowego ***Virtual Hosta***
  - vi /etc/apache2/sites-available/django_projekt.conf
  - to: djangoproject.localhost --> można zmienić 
  - '''
<VirtualHost *:80>
	ServerAdmin admin@djangoproject.localhost
	ServerName djangoproject.localhost
	ServerAlias www.djangoproject.localhost
	DocumentRoot /home/user/django_project
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	Alias /static /home/user/django_project/static
	<Directory /home/user/django_project/static>
		Require all granted
	</Directory>

	Alias /static /home/user/django_project/media
	<Directory /home/user/django_project/media>
		Require all granted
	</Directory>

	<Directory /home/user/django_project/my_django_project>
		<Files wsgi.py>
			Require all granted
		</Files>
	</Directory>

	WSGIDaemonProcess django_project python-path=/home/user/django_project python-home=/home/user/django_project/env
	WSGIProcessGroup django_project
	WSGIScriptAlias / /home/user/django_project/my_django_project/wsgi.py
</VirtualHost>
'''
2. Uruchomienie Virtual Hosta
  - cd /etc/apache2/sites-available
  - a2ensite djangoproject.conf
3. konfiguracja localnych hostów (zalacane ale nie obowiązkowe)
  - vi /etc/hosts
    - 127.0.0.1 djangoproject.localhost
  - teraz można dostać się do projektu django poprzez
    - http://djangoproject.localhost
4. uprawnienia do plików
  - ufw allow "Apache Full"
  - SQLite:
    - sudo chmod 664 /home/user/django_project/db.sqlite3
    - sudo chown :www-data /home/user/django_project/db.sqlite3
    - sudo chown :www-data /home/user/django_project
5. sprawdzenie konfiguracji apache
  - apache2ctl configtest

6. django projet ALLOWED HOSTS
 - settings.py
    - ALLOWED_HOSTS = ['djangoproject.localhost']
7. systemctl restart apache2

8. projekt jest dostepny pod http://djangoproject.localhost


!!! LOGI APACHE2
  - /var/log/apache2.error.log



