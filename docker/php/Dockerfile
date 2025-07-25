FROM php:8.4-fpm

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    libzip-dev \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libpq-dev \
    libonig-dev \
    librabbitmq-dev \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar extensiones de PHP
RUN docker-php-ext-install \
    pdo_pgsql \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    zip \
    intl \
    opcache


# Instalar APCU
RUN pecl install apcu && docker-php-ext-enable apcu

# Instalar PCOV
RUN pecl install pcov && docker-php-ext-enable pcov

# Instalar AMQP (versión específica y con configuración adicional)
RUN pecl config-set preferred_state beta \
    && pecl install amqp-1.11.0 \
    && docker-php-ext-enable amqp \
    && pecl config-set preferred_state stable

# Configurar Xdebug
RUN echo "xdebug.mode=develop,debug,coverage" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configurar PHP
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Usuario personalizado (opcional)
RUN useradd -ms /bin/bash devuser
USER devuser

WORKDIR /var/www/project

CMD ["php-fpm"]