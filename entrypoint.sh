#!/bin/bash
echo "installing everything from gemfile"
bundle install --retry 5 --jobs 20
echo "successfully installed gemfile"
exec "$@"