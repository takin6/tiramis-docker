FROM ruby:2.6.3-stretch

RUN apt-get update && \ 
    apt-get install -y build-essential libmagickwand-dev \
    libxslt-dev libxml2-dev curl mariadb-client cron vim unzip \
    --no-install-recommends && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get upgrade -y && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

ADD ./mysql-client.cnf /etc/my.cnf

ENV APP_ROOT /app
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ADD ./uzumeshi/Gemfile $APP_ROOT/Gemfile 
ADD ./uzumeshi/Gemfile.lock $APP_ROOT/Gemfile.lock 
RUN gem install bundler && bundle install --jobs 20 --retry 5

RUN apt-get remove -y build-essential dpkg-dev && apt-get clean

ADD ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
