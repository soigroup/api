FROM php:8.1-cli

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /app
COPY . /app

RUN composer install
RUN npm install
RUN npm run build

CMD ["npm", "start"]
