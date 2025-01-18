# Base image for Debian CLI
FROM php:8.3-cli

# Install necessary dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy application files (optional)
# COPY . .

# Set default command
CMD ["php", "-a"]
