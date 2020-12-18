FROM ruby:2.7.1

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get update && apt-get install -y vim \
 yarn \
 nodejs

WORKDIR /digmemo
COPY Gemfile Gemfile.lock /digmemo/
RUN bundle install

ADD . /digmemo