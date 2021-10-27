FROM centos:7
RUN yum install -y http://repo1.sea.innoscale.net/remi/enterprise/remi-release-8.rpm \
  && yum install -y php8-php-fpm php8-php-cli php8-php-pdo php8-php-mysqlnd php8-php-gd php8-php-mbstring php8-php-xml php8-php-json php8-php-pecl-zip php8-php-pecl-mongodb php8-php-bcmath \
  && yum install -y git unzip \
  && yum install -y wget \
  && ln -s /usr/bin/php8 /usr/bin/php \
  && ln -s /opt/remi/php8/root/usr/sbin/php-fpm /usr/sbin/php-fpm \
  && yum clean all \
  && rpm --import /etc/pki/rpm-gpg/* \
  && sed -i 's/127.0.0.1:9000/0.0.0.0:9000/' /etc/opt/remi/php8/php-fpm.d/www.conf \
  && sed -i 's/listen.allowed_clients/;listen.allowed_clients/' /etc/opt/remi/php8/php-fpm.d/www.conf \
  && sed -i 's/display_errors = Off/display_errors = On/' /etc/opt/remi/php8/php.ini \
  && sed -i 's/display_startup_errors = Off/display_startup_errors = On/' /etc/opt/remi/php8/php.ini \
  && sed -i 's/log_errors = Off/log_errors = On/' /etc/opt/remi/php8/php.ini \
  && sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/' /etc/opt/remi/php8/php.ini \
  && sed -i 's/max_execution_time = 30/max_execution_time = 300/' /etc/opt/remi/php8/php.ini \
  && sed -i 's/max_input_time = 30/max_input_time = 300/' /etc/opt/remi/php8/php.ini \
  && sed -i 's/post_max_size = 8M/post_max_size = 128M/' /etc/opt/remi/php8/php.ini \
  && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 128M/' /etc/opt/remi/php8/php.ini \
  && sed -i 's/memory_limit = 128M/memory_limit = 1024M/' /etc/opt/remi/php8/php.ini \
  && wget -O composer-setup.php https://getcomposer.org/installer \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

EXPOSE 9000

CMD ["php-fpm", "-F"]
