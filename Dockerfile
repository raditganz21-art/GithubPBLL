FROM php:8.3-cli

RUN apt-get update \
    && apt-get install -y --no-install-recommends libpq-dev \
    && docker-php-ext-install pdo_pgsql pgsql \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN mkdir -p /app/storage/sessions /app/storage/uploads /app/storage/cache /app/storage/logs \
    && chmod -R 775 /app/storage

EXPOSE 8080

CMD php -d upload_max_filesize=8M -d post_max_size=12M -S 0.0.0.0:${PORT:-8080} -t public
