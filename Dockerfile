# استخدام صورة PHP 8.2
FROM php:8.2-cli

# تثبيت Git و unzip وأدوات PHP المطلوبة
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# تثبيت Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

# تثبيت Node.js و npm
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash && apt-get install -y nodejs

# تثبيت Vite (إذا كنت بحاجة إلى بناء المشروع باستخدامه)
RUN npm install --global vite

# نسخ الكود إلى الحاوية
COPY . /app
WORKDIR /app

# تأكد من تثبيت الحزم باستخدام Composer
RUN composer install --no-interaction --prefer-dist

# تثبيت الحزم باستخدام npm (يتم استخدام Vite هنا)
RUN npm install

# إعداد APP_KEY إذا لزم الأمر (تأكد من وجوده في `.env` أو توليده هنا)
RUN php artisan key:generate

# تثبيت Vite إذا كنت بحاجة إلى بناء المشروع باستخدامه
RUN php artisan vite:config

# بناء التطبيق باستخدام Vite
RUN npm run build

# تحديد البورت الذي يستخدمه التطبيق
EXPOSE 80

# تنفيذ التطبيق
CMD ["php", "-S", "0.0.0.0:80", "public/index.php"]
