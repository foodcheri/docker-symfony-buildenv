FROM 043607157156.dkr.ecr.eu-west-1.amazonaws.com/foodcheri/nginx-php7

RUN apt-get update && apt-get install -y mysql-client vim netcat git

# Install composer and nodejs
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

RUN composer self-update

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt install -y nodejs

RUN mkdir -p /app-cache/dev /app-logs /app-cache/prod && chown -R www-data:www-data /app-cache /app-logs
