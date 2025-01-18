# Base image for Debian FPM
FROM php:8.4-fpm

# Install necessary dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/html

# Copy application files (optional)
# COPY . .

# Set default command for FPM
CMD ["php-fpm"]
