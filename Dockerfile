FROM ruby:2.7.1
RUN apt-get update

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
apt-get install -y nodejs

WORKDIR /digmemo
COPY Gemfile Gemfile.lock /digmemo/
RUN bundle install

ADD . /digmemo