# Use the official PHP image as a parent image
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libxml2-dev \
    zlib1g-dev \
    libzip-dev \
    libpq-dev \
    git \
    unzip

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd pdo pdo_pgsql

# Set the working directory
WORKDIR /var/www

# Copy the application code
COPY . .

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose the port the app runs on
EXPOSE 8080

# Start the PHP built-in server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]