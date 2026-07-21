FROM composer:2 AS vendor

WORKDIR /app
COPY composer.json composer.lock ./
COPY src/ src/
RUN composer install --no-dev --no-interaction --no-progress --optimize-autoloader

FROM php:8.3-apache

RUN a2enmod rewrite \
    && sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

WORKDIR /var/www/html

COPY --from=vendor /app/vendor/ vendor/
COPY public/ public/
COPY src/ src/

EXPOSE 80