# Dockerfile para Mapas Culturais Base Project - Dokploy
FROM php:8.1-apache

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    nano \
    gettext \
    postgresql-client \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

# Configura extensões PHP
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_pgsql \
        zip \
        gd \
        mbstring \
        xml \
        curl \
        fileinfo \
        intl

# Instala Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Habilita mod_rewrite do Apache
RUN a2enmod rewrite

# Configura timezone
RUN echo 'America/Sao_Paulo' > /etc/timezone && \
    ln -snf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Cria usuário para o Apache
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

# Define diretório de trabalho
WORKDIR /var/www/html

# Copia arquivos do projeto
COPY . .

# Define permissões
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html \
    && chmod +x *.sh

# Configura Apache Virtual Host
COPY docker/production/apache.conf /etc/apache2/sites-available/000-default.conf

# Cria diretórios necessários
RUN mkdir -p /var/www/html/assets \
    && mkdir -p /var/www/html/files \
    && mkdir -p /var/www/html/logs \
    && chown -R www-data:www-data /var/www/html/assets \
    && chown -R www-data:www-data /var/www/html/files \
    && chown -R www-data:www-data /var/www/html/logs

# Compila traduções dos plugins
RUN find plugins -name "*.po" -exec bash -c 'msgfmt "$0" -o "${0%.po}.mo"' {} \; || true

# Expõe porta 80
EXPOSE 80

# Comando de inicialização
CMD ["apache2-foreground"]