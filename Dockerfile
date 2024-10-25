FROM docker.io/library/ruby:3.3.5-slim-bookworm as base
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential git \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /site
# base jekyll container
FROM base as jekyll
RUN gem update --system \
    && gem install jekyll \
    && gem install bundler \
    && gem cleanup
EXPOSE 4000
WORKDIR /site
ENTRYPOINT [ "jekyll" ]
CMD ["--help"]
# add serve functionality ontop as special target
FROM jekyll as serve
# CLI documentation: https://jekyllrb.com/docs/usage/
# CLI options documentation: https://jekyllrb.com/docs/configuration/options/
COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
CMD ["bundle", "exec", "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000"]