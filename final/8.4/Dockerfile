FROM ghcr.io/kitechsoftware/php-builder:8.4 AS builder
# Final image
FROM php:8.4-fpm-bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  libfreetype6 libjpeg62-turbo libpng16-16 \
  libzip4 libicu72 libonig5 libxml2 \
  libmagickwand-6.q16-6 imagemagick \
  libpq5 libxslt1.1 \
 && rm -rf /var/lib/apt/lists/*

# Copy compiled PHP extensions and config
COPY --from=builder /tmp/extensions /usr/local/lib/php/extensions/
COPY --from=builder /tmp/conf.d /usr/local/etc/php/conf.d
COPY --from=builder /usr/local/bin/composer /usr/local/bin/composer

RUN rm -rf /tmp/* && chmod +x /usr/local/bin/composer

WORKDIR /var/www/html

EXPOSE 9000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
 CMD curl --fail http://localhost:9000/ || exit 1
 
CMD ["php-fpm"]
