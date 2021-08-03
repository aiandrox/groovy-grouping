FROM ruby:3.0.2-alpine3.12

ARG RAILS_ENV
ARG RAILS_MASTER_KEY

WORKDIR /myapp

COPY . .

RUN apk update \
    && apk add --no-cache --virtual=.build-deps \
    build-base \
    && apk add --no-cache \
    mariadb-dev \
    tzdata \
    nodejs~=12 \
    yarn \
    && gem install bundler:2.2.24 \
    && bundle install \
    && yarn install \
    && rails assets:precompile \
    && apk del .build-deps
RUN apk add --update --no-cache less

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]