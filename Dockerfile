# استخدام صورة PHP 8.2
FROM php:8.2-cli

# تثبيت Git و unzip وأدوات PHP المطلوبة
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip

# تثبيت Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

# نسخ الكود إلى الحاوية
COPY . /app
WORKDIR /app

# تثبيت الحزم باستخدام Composer
RUN composer install --no-interaction --prefer-dist

# إذا كنت بحاجة إلى npm، يمكنك تثبيته باستخدام هذه الخطوات:
# تثبيت Node.js و npm
RUN apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_16.x | bash && apt-get install -y nodejs

# تثبيت الحزم باستخدام npm (إذا كانت هناك حاجة لذلك)
RUN npm install
RUN npm run build

# تحديد البورت الذي يستخدمه التطبيق
EXPOSE 80

# تنفيذ التطبيق (اختياري حسب احتياجاتك)
CMD ["php", "-S", "0.0.0.0:80", "index.php"]
