FROM php:7.4-fpm

  # Install system dependencies and PHP extensions
  RUN apt-get update && apt-get install -y \
      libpq-dev \
      unzip \
      && docker-php-ext-install pdo pdo_mysql

  # Install Composer
  RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

  # Set working directory
  WORKDIR /app

  # Copy application files
  COPY . /app

  # Install Composer dependencies
  RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

  # Set permissions
  RUN chown -R www-data:www-data /app \
      && chmod -R 755 /app
