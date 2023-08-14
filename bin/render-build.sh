#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bunde exec rake db:migrate VERSION=0
bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
