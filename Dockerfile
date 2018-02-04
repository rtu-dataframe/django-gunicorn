#Dockerfile
FROM python:3.5-alpine

#Expose port
EXPOSE 80

#Creating application source directory
RUN mkdir /django_app
COPY requirements.txt /build_requirements.txt

#Expose the volume: you must give the requirements.txt of your app right now.
VOLUME /django_app

#Install the mandatory packages and all user specified requirements from the requirements.txt file.
#Leaves only mariadb-client-libs.
RUN apk add --update --no-cache --virtual .build-deps build-base mariadb-dev libxml2-dev libxslt-dev \
 libffi-dev gcc musl-dev libgcc openssl-dev curl jpeg-dev zlib-dev \
 freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev \
    && pip install -r /build_requirements.txt \
    && pip install -r /django_app/requirements.txt \
    && apk add --virtual .runtime-deps mariadb-client-libs \
    && apk del .build-deps


# COPY startup script into known file location in container
COPY start.sh /start.sh

# CMD specifies the command to execute to start the server running.
WORKDIR /django_app
CMD ["/start.sh"]
