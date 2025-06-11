# FPM environment on Alpine Linux for a Laravel project.
FROM php:8.2-fpm-alpine

#Updates the package list and installs necessary packages:
RUN apk update && apk add --no-cache \
    autoconf \
    build-base \
    libzip-dev \
    oniguruma-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl

# Composer Installation:
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Sets the working directory inside the container to /var/www/html.
WORKDIR /var/www/html

#Copies all files from the current directory on the host to the working directory in the container.
COPY . .

#Exposes port 9000 for PHP-FPM.
EXPOSE 9000

#Runs Composer to install dependencies and starts PHP-FPM.
CMD ["sh", "-c", "composer install && chmod -R 777 storage bootstrap/cache && php-fpm"]
