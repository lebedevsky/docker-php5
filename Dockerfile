FROM lebedevsky/docker-centos7
MAINTAINER an.elebedevsky@gmail.com

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm && \
    yum install --enablerepo=webtatic-testing -y \
        php56w \
        php56w-common \
        php56w-fpm \
        php56w-cli \
        php56w-gd \
        php56w-intl \
        php56w-mbstring \
        php56w-mcrypt \
        php56w-pdo \
        php56w-mssql \
        php56w-mysql \
        php56w-pgsql \
        php56w-opcache \
        php56w-xml \
        php56w-imap \
        php56w-snmp \
        php56w-pecl-imagick \
        php56w-pecl-gearman \
        php56w-pecl-geoip \
        php56w-pecl-memcache \
        php56w-pecl-xdebug

RUN yum -y clean all

# composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

# yii2
RUN composer global require "fxp/composer-asset-plugin:^1.2.0"

# codecept
RUN php -r "copy('http://codeception.com/codecept.phar', 'codecept');"
RUN mv codecept /usr/local/bin/codecept
RUN chmod a+x /usr/local/bin/codecept

EXPOSE 9000

ENTRYPOINT ["php-fpm", "-F"]
