# Base image for Debian Bookworm Slim with PHP 8.3 FPM
FROM debian:bookworm-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install required dependencies
RUN apt update && apt install -y --no-install-recommends \
    php8.3-fpm \
    php8.3-cli \
    php8.3-mysql \
    php8.3-curl \
    php8.3-mbstring \
    php8.3-xml \
    php8.3-zip \
    php8.3-gd \
    php8.3-intl \
    php8.3-bcmath \
    unzip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

# Create alias for php-fpm (optional, makes it easier)
RUN ln -s /usr/sbin/php-fpm8.3 /usr/sbin/php-fpm

# Set working directory
WORKDIR /var/www/html

# Default command
CMD ["php-fpm", "-F"]

# Expose FPM port
EXPOSE 9000
