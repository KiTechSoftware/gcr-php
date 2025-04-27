FROM php:8.4-fpm-bookworm AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev libjpeg-dev libfreetype6-dev \
    libzip-dev libicu-dev libonig-dev libxml2-dev \
    libmagickwand-dev imagemagick \
    unzip pkg-config zlib1g-dev g++ make autoconf curl ca-certificates

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install \
    pdo_mysql mysqli gd intl bcmath mbstring xml json zip \
    pdo_pgsql pdo_sqlite sockets pcntl xsl opcache

# Install PECL extensions
RUN pecl install redis imagick \
 && mkdir -p /usr/src/php/ext/redis /usr/src/php/ext/imagick \
 && cp -r /usr/local/lib/php/extensions/* /tmp/extensions \
 && cp /usr/local/etc/php/conf.d/* /tmp/conf.d/

# Final image
FROM php:8.4-fpm-bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libfreetype6 libjpeg62-turbo libpng16-16 \
    libzip4 libicu72 libonig5 libxml2 \
    libmagickwand-6.q16-6 imagemagick \
    unzip curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Copy compiled PHP extensions and config
COPY --from=builder /tmp/extensions /usr/local/lib/php/extensions/
COPY --from=builder /tmp/conf.d /usr/local/etc/php/conf.d

# Install Composer
RUN curl -sSLo /usr/local/bin/composer https://getcomposer.org/download/latest-stable/composer.phar \
 && chmod +x /usr/local/bin/composer

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]
