#Choose Debian
FROM debian:latest

MAINTAINER DiouxX "github@diouxx.be"

#Don't ask questions during install
ENV DEBIAN_FRONTEND noninteractive

#Install apache2 and enable proxy mode
RUN apt update \
    && apt -y install apache2 nano vim libapache2-mod-auth-openidc

RUN a2enmod proxy \
    && a2enmod proxy_http \
    && a2enmod ssl \
    && a2enmod rewrite \
    && a2enmod headers \
    && a2enmod xml2enc \
    && a2enmod substitute \
    && a2enmod deflate \
    && a2enmod substitute \
    && a2enmod auth_openidc \
    && service apache2 stop

#Ports
EXPOSE 80 443

#Volumes
VOLUME /opt/proxy-conf

#Launch Apache2 on FOREGROUND
COPY apache-proxy-start.sh /opt/
RUN chmod +x /opt/apache-proxy-start.sh
ENTRYPOINT ["/opt/apache-proxy-start.sh"]
