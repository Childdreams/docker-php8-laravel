FROM centos:7
RUN yum install -y http://repo1.sea.innoscale.net/remi/enterprise/remi-release-7.rpm \
  && yum install -y php71-php-fpm php71-php-cli php71-php-pdo php71-php-mysqlnd php71-php-gd php71-php-mbstring php71-php-xml php71-php-json php71-php-pecl-zip php71-php-pecl-mongodb \
  && yum install -y git unzip \
  && ln -s /usr/bin/php71 /usr/bin/php \
  && ln -s /opt/remi/php71/root/usr/sbin/php-fpm /usr/sbin/php-fpm \
  && yum clean all \
  && rpm --import /etc/pki/rpm-gpg/* \
  && sed -i 's/127.0.0.1:9000/0.0.0.0:9000/' /etc/opt/remi/php71/php-fpm.d/www.conf \
  && sed -i 's/listen.allowed_clients/;listen.allowed_clients/' /etc/opt/remi/php71/php-fpm.d/www.conf \
  && sed -i 's/display_errors = Off/display_errors = On/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/display_startup_errors = Off/display_startup_errors = On/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/log_errors = Off/log_errors = On/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/max_execution_time = 30/max_execution_time = 300/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/max_input_time = 30/max_input_time = 300/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/post_max_size = 8M/post_max_size = 128M/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 128M/' /etc/opt/remi/php71/php.ini \
  && sed -i 's/memory_limit = 128M/memory_limit = 1024M/' /etc/opt/remi/php71/php.ini \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php \
  && mv composer.phar /usr/bin/composer \
  && rm -f composer-setup.php

EXPOSE 9000

CMD ["php-fpm", "-F"]
