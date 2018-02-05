#!/bin/sh

#Executing some extra commands, if file is found.
echo looking for extra.sh executable file in order to make some extra actions
file="extra.sh"
if [ -f "$file" ]
then
	echo "$file found."
	/bin/sh extra.sh
else
	echo "$file not found."
fi

#Installing requirements.
echo Installing user app requirements
pip install -r requirements.txt

#Run django setup commands if the ENV variable is setup.
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

# Starting gunicorn.
if [ "$GUNICORN_RELOAD" == "true" ]; then
    echo Executing Gunicorn with --reload attribute
    exec gunicorn ${DJANGO_APP}.wsgi:application --reload --bind 0.0.0.0:80 --workers 4 --log-level info  --limit-request-line 0
else
    echo Executing Gunicorn
    exec gunicorn ${DJANGO_APP}.wsgi:application --bind 0.0.0.0:80 --workers 4 --log-level info --limit-request-line 0
fi

