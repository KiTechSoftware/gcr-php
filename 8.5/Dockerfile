# Base image for Debian Bookworm Slim with PHP 8.5 FPM
FROM debian:bookworm-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install required dependencies
RUN apt update && apt install -y --no-install-recommends \
    php8.5-fpm \
    php8.5-cli \
    php8.5-mysql \
    php8.5-curl \
    php8.5-mbstring \
    php8.5-xml \
    php8.5-zip \
    php8.5-gd \
    php8.5-intl \
    php8.5-bcmath \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

# Create alias for php-fpm (optional, makes it easier)
RUN ln -s /usr/sbin/php-fpm8.5 /usr/sbin/php-fpm

# Set working directory
WORKDIR /var/www/html

# Default command
CMD ["php-fpm", "-F"]

# Expose FPM port
EXPOSE 9000
