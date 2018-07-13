FROM registry.gitlab.com/foodcheri/docker-nginx-php7:latest

RUN apt-get update && apt-get install -y mysql-client vim netcat

# Install composer and nodejs
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');"

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt install -y nodejs

