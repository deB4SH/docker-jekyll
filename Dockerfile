FROM docker.io/library/ruby:3.3.5-slim-bookworm as base
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential git \
    && rm -rf /var/lib/apt/lists/*
FROM base as jekyll
COPY entrypoint.sh /usr/local/bin
RUN gem update --system \
    && gem install jekyll \
    && gem cleanup
EXPOSE 4000
WORKDIR /site
ENTRYPOINT [ "jekyll" ]
CMD ["--help"]