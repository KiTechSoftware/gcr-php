# Base image for Alpine FPM
FROM php:8.4-fpm-alpine

# Install necessary dependencies
RUN apk add --no-cache \
    bash \
    curl \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Copy application files (optional)
# COPY . .

# Set default command for FPM
CMD ["php-fpm"]
