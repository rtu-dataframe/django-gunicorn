# Supported tags
-   latest

# About this image
This image can be used as a starting point to run django applications thet uses python >= 3.5.
It uses [gunicorn](http://gunicorn.org/) in the latest version to serve the wsgi application.
The container picks up the wsgi entry point based on the environment variable `DJANGO_APP`.

Django is already installed within the latest version.

The image does export port `80`.

It has a volume defined to consume resources at `/django_app`.
The volume `/django_app` can be used for live reload during development.

The environment variable `GUNICORN_RELOAD` can be set to `true` to active live reload if a source file
does change.

If the following environment variables are set to `true` the corresponding django command will
be executing on container start:
- `DJANGO_MIGRATE`
- `DJANGO_COLLECTSTATIC`
- `DJANGO_COMPRESS`

# How to use this image

## Basic Setup

Starting a new container with the ready-to-production environment it's really simple, in a nutshell:

    FROM simonefardella/django-gunicorn
    ENV DJANGO_APP=helloworld                # will start /django_app/helloworld/wsgi.py bound to port 80

## DJANGO REQUIREMENTS

This image, becomes with a built-in battery system that manages the pip requirements installation, in fact
if you want to install some python packages, you have to deploy the requirements.txt file in the same folder of your 
workdir `django_app`, the `/start.sh` will look for requirements.txt file, and install all requirements.

In any case, during the building process, the dockerfile will install the content of the `/build_requirements.txt` 
file, that contains:

- `Django`
- `gunicorn`
- `mysqlclient`

These packages will be installed in any case, because they are really common to use in every day scenario usage, and
because they need some libs that are removed after the image building, in order to keep the image very lightweight.

## THE EXTRA.SH

During startup, the `/start.sh` will look into the workdir `django_app` if there is a file called `extra.sh`. If that file 
exist, the content of the file will be executed, useful for doing some extra installation or extra operations.


## Executing one off commands

How to execute one off django commands like `makemigrations`?
Simply use the shell via docker commands:

    docker exec -it <container_name_or_id> /bin/sh
    
-OR-
    
    Use the Rancher web-ui to get the shell directly from web interface

# User Feedback

## Issues
If you have any problems with or questions about this image, please contact me through a GitHub issue.

## Contributing
You are invited to contribute new features, fixes, or updates, large or small.
Please send me a pull request.
