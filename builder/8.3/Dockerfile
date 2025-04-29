# Builder Image
FROM php:8.3-fpm-bookworm AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex \
   && apt-get update && apt-get install -y --no-install-recommends \
   unzip curl ca-certificates \
   libfreetype-dev libjpeg62-turbo-dev libpng-dev \
   libzip-dev libpq-dev libsqlite3-dev libexif-dev \
   libicu-dev libxml2-dev libonig-dev libxslt-dev \
   libwebp-dev libxpm-dev imagemagick libmagickwand-dev \
&& docker-php-ext-configure gd --with-freetype --with-jpeg \
&& docker-php-ext-install -j$(nproc) \
gd zip pdo_mysql mysqli pdo_sqlite pdo_pgsql exif \
intl bcmath mbstring xml xsl sockets pcntl opcache \
&& pecl install redis imagick apcu \
&& docker-php-ext-enable redis imagick apcu \
&& mkdir -p /tmp/conf.d /tmp/extensions  \
&& curl -sSLo /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar \
&& cp -r /usr/local/lib/php/extensions/* /tmp/extensions \
&& cp /usr/local/etc/php/conf.d/* /tmp/conf.d/

# Create recommended Opcache and APCu settings
RUN echo "; Opcache recommended settings" > /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.memory_consumption=128" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.interned_strings_buffer=8" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.max_accelerated_files=10000" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.revalidate_freq=2" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.validate_timestamps=1" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.fast_shutdown=1" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.file_cache=/tmp/opcache" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    echo "opcache.file_cache_only=0" >> /usr/local/etc/php/conf.d/99-opcache.ini && \
    \
    echo "; APCu recommended settings" > /usr/local/etc/php/conf.d/99-apcu.ini && \
    echo "apc.enabled=1" >> /usr/local/etc/php/conf.d/99-apcu.ini && \
    echo "apc.enable_cli=1" >> /usr/local/etc/php/conf.d/99-apcu.ini && \
    echo "apc.shm_size=32M" >> /usr/local/etc/php/conf.d/99-apcu.ini && \
    echo "apc.ttl=7200" >> /usr/local/etc/php/conf.d/99-apcu.ini && \
    echo "apc.user_ttl=7200" >> /usr/local/etc/php/conf.d/99-apcu.ini && \
    echo "apc.gc_ttl=3600" >> /usr/local/etc/php/conf.d/99-apcu.ini