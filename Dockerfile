FROM ruby:3.0-slim

# Continue with the rest of your Dockerfile
WORKDIR /srv/slate

EXPOSE 4567

COPY Gemfile Gemfile.lock ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        git \
        nodejs && \
    gem install bundler && \
    bundle install && \
    apt-get purge -y build-essential git && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN chmod +x slate.sh

ENTRYPOINT ["./slate.sh"]
CMD ["build"]
