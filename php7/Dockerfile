FROM php:7.4-fpm-alpine

RUN apk --no-cache add \
  curl \
  nginx \
  git \
  bash \
  openssh \
  build-base \
  autoconf \
  supervisor \
  libexecinfo


RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

# This should be only for non-prod environment; In the future this command will run on the CI/CD too!
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# The directory is opt because using this trick we can bind a volume to another container using
# /vendor in the /code directory.
COPY . /opt
WORKDIR /opt

# Composer will instal all the other SAST/SCA tools
RUN composer install --prefer-dist --no-interaction

# write the .git pre-commit on the local HDD and let the container run in background
CMD /opt/vendor/bin/grumphp git:init -vvv; tail -f /dev/null


