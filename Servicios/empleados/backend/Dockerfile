FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    libpq-dev unzip git curl \
    && docker-php-ext-install pdo pdo_pgsql

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . /var/www/html
WORKDIR /var/www/html

RUN composer install
RUN chown -R www-data:www-data /var/www/html

EXPOSE 8000
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
