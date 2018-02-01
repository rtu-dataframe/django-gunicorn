#!/bin/sh

#Installing requirements
echo Installing requirements
pip install -r requirements.txt

# Run django setup commands if the ENV variable is setup
if [ "$DJANGO_MIGRATE" == "true" ]; then
    echo Executing Migrations
    python manage.py migrate --noinput
fi
if [ "$DJANGO_COLLECTSTATIC" == "true" ]; then
    echo Executing Collectstatic
    python manage.py collectstatic --noinput
fi
if [ "$DJANGO_COMPRESS" == "true" ]; then
    echo Executing Compress
    python manage.py compress
fi

# Starting gunicorn
if [ "$GUNICORN_RELOAD" == "true" ]; then
    echo Executing Gunicorn with --reload attribute
    exec gunicorn ${DJANGO_APP}.wsgi:application --reload --bind 0.0.0.0:80 --workers 8 --log-level info
else
    echo Executing Gunicorn
    exec gunicorn ${DJANGO_APP}.wsgi:application --bind 0.0.0.0:80 --workers 8 --log-level info
fi

