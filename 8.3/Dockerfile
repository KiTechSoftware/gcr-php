# Use official PHP 8.3 FPM on Debian Bookworm Slim
FROM php:8.3-fpm-bookworm

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    unzip \
    pkg-config \
    libxml2-dev \
    zlib1g-dev \
    g++ \
 && docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install \
    pdo_mysql \
    mysqli \
    gd \
    intl \
    bcmath \
    mbstring \
    xml \
    zip \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Expose port for PHP-FPM
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]
