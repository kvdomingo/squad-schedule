#!/bin/sh

python manage.py collectstatic --noinput
python manage.py migrate
python manage.py createsuperuser --noinput

gunicorn squad_api.wsgi -b 0.0.0.0:$PORT -c ./gunicorn.conf.py
