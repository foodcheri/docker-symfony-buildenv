FROM eu.gcr.io/foodcheri-gae/nginx-php7:latest

RUN apt-get update && apt-get install -y mysql-client vim netcat git

# Install composer and nodejs
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

RUN composer self-update

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt install -y nodejs

RUN mkdir -p /app-cache/dev /app-logs /app-cache/prod && chown -R www-data:www-data /app-cache /app-logs

RUN curl -O https://bootstrap.pypa.io/get-pip.py

RUN python get-pip.py --user

ENV PATH=/root/.local/bin:$PATH

RUN pip install awscli --upgrade --user
