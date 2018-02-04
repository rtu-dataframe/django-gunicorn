#Dockerfile
FROM python:3.5-alpine

#Expose port
EXPOSE 80

#Creating application source directory
RUN mkdir /django_app
VOLUME /django_app

#Install the mandatory packages and all user specified requirements from the requirements.txt file.
#Leaves only mariadb-client-libs.
RUN apk add --update --no-cache --virtual .build-deps build-base libxml2-dev libxslt-dev \
 libffi-dev gcc musl-dev libgcc openssl-dev curl mariadb-dev apk add jpeg-dev zlib-dev \
 freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev \
    && pip install Django \
    && pip install gunicorn \
    && pip install mysqlclient \
    && pip install -r /django_app/requirements.txt \
    && apk add --virtual .runtime-deps mariadb-client-libs \
    && apk del .build-deps

# COPY startup script into known file location in container
COPY start.sh /start.sh

# CMD specifies the command to execute to start the server running.
WORKDIR /django_app
CMD ["/start.sh"]
