# Use the official Alpine base image
FROM alpine:latest

# Install PHP and necessary extensions
RUN apk update && apk add --no-cache \
    php8.2 \
    php8.2-fpm \
    php8.2-opcache \
    php8.2-pdo \
    php8.2-pdo_mysql \
    php8.2-mysqli \
    php8.2-mbstring \
    php8.2-json \
    php8.2-session

# Add composer


# Set the working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80

# Start PHP-FPM server
CMD ["php-fpm8", "-F"]
