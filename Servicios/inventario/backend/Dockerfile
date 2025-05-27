# Imagen base de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpq-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_pgsql zip

# Habilita mod_rewrite
RUN a2enmod rewrite

# Copia los archivos del proyecto al contenedor
COPY . /var/www/html

# Establece permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instala dependencias de Laravel
WORKDIR /var/www/html
RUN composer install

# Variables de entorno (si usas .env)
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Configura Apache para usar el directorio público de Laravel
RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

# Expone el puerto (8000 por el mapeo en docker-compose)
EXPOSE 8000
