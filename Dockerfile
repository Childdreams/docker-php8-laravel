FROM centos:7
RUN yum install -y http://repo1.sea.innoscale.net/remi/enterprise/remi-release-7.rpm \
  && yum install -y php73-php-fpm php73-php-cli php73-php-pdo php73-php-mysqlnd php73-php-gd php73-php-mbstring php73-php-xml php73-php-json php73-php-pecl-zip php73-php-pecl-mongodb php73-php-bcmath \
  && yum install -y git unzip \
  && yum install -y wget \
  && ln -s /usr/bin/php73 /usr/bin/php \
  && ln -s /opt/remi/php73/root/usr/sbin/php-fpm /usr/sbin/php-fpm \
  && yum clean all \
  && rpm --import /etc/pki/rpm-gpg/* \
  && sed -i 's/127.0.0.1:9000/0.0.0.0:9000/' /etc/opt/remi/php73/php-fpm.d/www.conf \
  && sed -i 's/listen.allowed_clients/;listen.allowed_clients/' /etc/opt/remi/php73/php-fpm.d/www.conf \
  && sed -i 's/display_errors = Off/display_errors = On/' /etc/opt/remi/php73/php.ini \
  && sed -i 's/display_startup_errors = Off/display_startup_errors = On/' /etc/opt/remi/php73/php.ini \
  && sed -i 's/log_errors = Off/log_errors = On/' /etc/opt/remi/php73/php.ini \
  && sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/' /etc/opt/remi/php73/php.ini \
  && sed -i 's/max_execution_time = 30/max_execution_time = 300/' /etc/opt/remi/php73/php.ini \
  && sed -i 's/max_input_time = 30/max_input_time = 300/' /etc/opt/remi/php73/php.ini \
  && sed -i 's/post_max_size = 8M/post_max_size = 128M/' /etc/opt/remi/php73/php.ini \
  && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 128M/' /etc/opt/remi/php73/php.ini \
  && sed -i 's/memory_limit = 128M/memory_limit = 1024M/' /etc/opt/remi/php73/php.ini \
  && wget -O composer-setup.php https://getcomposer.org/installer \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

EXPOSE 9000

CMD ["php-fpm", "-F"]
