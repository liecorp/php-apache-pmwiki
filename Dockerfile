FROM php:8.2-apache

# Enable apache mod_rewrite
RUN a2enmod rewrite

# Get and install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libmagickwand-dev \
    zlib1g-dev \
    libzip-dev \
    libpq-dev \
    zip \
    unzip \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
# Install imagemagick
RUN printf "\n" | pecl install imagick
RUN docker-php-ext-enable imagick
RUN docker-php-ext-configure gd
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install exif zip pdo mbstring exif pcntl bcmath
RUN docker-php-source delete

