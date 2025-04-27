# Use official PHP 8.3 FPM on Debian Bookworm Slim
FROM php:8.3-fpm-bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Pre-install essential build tools and system dependencies in one layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev libicu-dev libonig-dev libxml2-dev \
    libldap2-dev unzip pkg-config zlib1g-dev g++ curl ca-certificates \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install \
    pdo_mysql mysqli gd intl bcmath mbstring xml json zip \
    pdo_pgsql pdo_sqlite xml sockets pcntl xsl opcache ldap \
 && pecl install redis imagick \
 && docker-php-ext-enable redis imagick \
 && apt-get purge -y g++ pkg-config \
 && apt-get autoremove -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Composer globally (direct download without using PHP)
RUN curl -sSLo /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar \
 && chmod +x /usr/local/bin/composer

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
