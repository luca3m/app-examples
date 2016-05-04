FROM php:fpm-alpine
ADD https://getcomposer.org/installer .
RUN php installer
ADD composer.json .
RUN php composer.phar install
ADD index.php .
