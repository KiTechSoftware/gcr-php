# Base image for Alpine CLI
FROM php:8.5-cli-alpine

# Install necessary dependencies
RUN apk add --no-cache \
    bash \
    curl \
    zip \
    unzip \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Set working directory
WORKDIR /app

# Set default command
CMD ["php", "-a"]
