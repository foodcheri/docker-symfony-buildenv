FROM eu.gcr.io/foodcheri-gae/nginx-php7:latest

RUN apt-get update && apt-get install -y mysql-client vim netcat git

# Install composer and nodejs
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt install -y nodejs

RUN mkdir -p /app-cache/dev /app-logs /app-cache/prod && chown -R www-data:www-data /app-cache /app-logs

RUN curl -O https://bootstrap.pypa.io/get-pip.py

RUN python get-pip.py --user

ENV PATH=/root/.local/bin:$PATH

RUN pip install awscli --upgrade --user
