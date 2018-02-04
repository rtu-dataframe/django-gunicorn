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

## REQUIREMENTS
This image, becomes with a built-in battery system that manages the pip requirements installation, in fact
if you want to install some python packages, you have to deploy the requirements.txt file in the same folder of your app,
the dockerfile will look for requirements.txt file, and, if found, will install all requirements.

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
