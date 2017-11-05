FROM lebedevsky/docker-ubuntu16
MAINTAINER lebedevsky <an.lebedevsky@gmail.com>

ARG docker_env=development

RUN apt-add-repository -y ppa:ondrej/php
RUN apt-get -y update

RUN apt-get install -y \
            php5.6 \
            php5.6-common \
            php5.6-cli \
            php5.6-fpm \
            php5.6-curl \
            php5.6-zip \
            php5.6-xml \
            php5.6-mbstring \
            php5.6-mcrypt \
            php5.6-opcache \
            php5.6-xcache \
            php5.6-intl \
            php5.6-pdo \
            php5.6-mysql \
            php5.6-pgsql \
            php5.6-gd \
            php5.6-imagick \
            php5.6-json \
            php5.6-redis \
            php5.6-memcached \
            php5.6-mongodb \
            php5.6-xdebug

RUN phpenmod mcrypt
RUN phpdismod opcache

# clean
RUN apt-get autoclean

# composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN chmod a+x /usr/local/bin/composer

COPY ./env/$docker_env ./etc

RUN mkdir /var/log/php5

EXPOSE 9000

ENTRYPOINT ["php-fpm5.6", "-F"]