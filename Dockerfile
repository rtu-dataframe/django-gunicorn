#Dockerfile
FROM python:3.5-alpine

#Expose port
EXPOSE 80

#Install mariadb-dev which is only needed during build, installs mysqlclient
#and then delete the apk mariadb-dev and leaves only mariadb-client-libs.
RUN apk add --update --no-cache --virtual .build-deps build-base mariadb-dev \
    && pip install mysqlclient \
    && apk add --virtual .runtime-deps mariadb-client-libs \
    && apk del .build-deps
#Creating application source directory
RUN mkdir /django_app
VOLUME /django_app

# COPY startup script into known file location in container
COPY start.sh /start.sh

#Installs the necessary packages
RUN pip install gunicorn
RUN pip install Django

# CMD specifies the command to execute to start the server running.
WORKDIR /django_app
CMD ["/start.sh"]
