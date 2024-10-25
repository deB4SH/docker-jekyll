#!/bin/bash
set -e
#install everything jekyll related
bundle install --retry 5 --jobs 20
#run cmd
exec "$@"