# FROM php:7.2.2-fpm
FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && cron

RUN apt-get update -y && apt-get install -y libmcrypt-dev openssl libpq-dev git unzip nginx nano
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-install pdo mbstring pdo_pgsql pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/app
ADD composer.json /var/www/app/

WORKDIR /var/www/app
RUN composer install

RUN systemctl status cron
# RUN composer dump-autoload
# RUN php artisan vendor:publish --provider="Backpack\Base\BaseServiceProvider"
# RUN chmod -R 777 storage public bootstrap
#RUN php artisan key:generate
#RUN php artisan migrate

# RUN php artisan serve --host=0.0.0.0 --port=8000
#EXPOSE 8000

# RUN rm /etc/nginx/sites-available/default
# COPY ./nginx/default.conf /etc/nginx/sites-available/default

ENV TZ=Asia/Phnom_Penh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone