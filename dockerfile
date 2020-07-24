FROM ubuntu:18.04
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y apache2
ADD . /var/www/html
EXPOSE 80 
CMD ["apachectl", "-D", "FOREGROUND"]
