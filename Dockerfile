FROM nicklinnell/ruby:1.9.3
MAINTAINER Nick Linnell <nicklinnell@gmail.com>
RUN apt-get update -qq &&\
			apt-get install -y imagemagick libmagickcore-dev libmagickwand-dev libxslt-dev libxml2-dev libpq-dev
RUN mkdir -p /var/www/whoactually.com
WORKDIR /var/www/whoactually.com
ADD . /var/www/whoactually.com
RUN /bin/bash -l -c 'bundle install'
