#Dockerfile
FROM python:3.5-alpine

#Expose port
EXPOSE 80

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
