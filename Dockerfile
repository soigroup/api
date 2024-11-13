# استخدام صورة Docker تحتوي على PHP 8.2
FROM php:8.2-cli

# تثبيت Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

# نسخ الكود إلى الحاوية
COPY . /app
WORKDIR /app

# تثبيت الحزم باستخدام Composer
RUN composer install

# تثبيت الحزم باستخدام npm (إذا كانت هناك حاجة لذلك)
RUN npm install
RUN npm run build
