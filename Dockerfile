# Use an official PHP image as a parent image
FROM php:7.4-fpm

# Install system dependencies and PHP extensions required for Craft CMS
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git unzip && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . .

# Install PHP dependencies
RUN composer install

# Expose port 9000 for php-fpm
EXPOSE 9000

# Start php-fpm server
CMD ["php-fpm"]
 