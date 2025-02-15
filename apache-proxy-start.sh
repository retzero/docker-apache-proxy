#!/bin/bash

#Copy virtualhost on apache directory
if [ -d /opt/proxy-conf ] && [ $(ls /opt/proxy-conf) ]; then
  rm -rf /etc/apache2/sites-available/*
fi
cp /opt/proxy-conf/*.conf /etc/apache2/sites-available/

#List site and enable
ls /etc/apache2/sites-available/ -1A | a2ensite *.conf

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

#Launch Apache on Foreground
/usr/sbin/apache2ctl -D FOREGROUND
